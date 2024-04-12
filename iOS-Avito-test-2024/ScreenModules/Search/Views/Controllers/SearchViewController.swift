//
//  SearchViewController.swift
//  iOS-Avito-test-2024


import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModelProtocol
 
    private let searchTextField = SearchTextField()
    private let promptStackView = PromptStackView()
    private let resultsCollectionView = ResultCollectionView()
    private let categoriesStackView = CategoriesStackView()
    private let limitStackView = LimitStackView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private var topConstraint = NSLayoutConstraint()
    private var searchParameters = SearchParameters()
    
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.state.bind { [weak self] state in
            guard let state else { return }
            switch state {
            case .initial:
                self?.resultsCollectionView.presentMockSkeleton()
            
            case .loading:
                self?.topConstraint.constant = 10
                UIView.animate(withDuration: 0.5) {
                    self?.view.layoutIfNeeded()
                }
                self?.startActivityAnimation()
                self?.presentMockCollectionView()
                self?.hideParameters()
                
            case .success(let dataSource):
                self?.resultsCollectionView.cellDataSource = dataSource
                self?.activityIndicator.stopAnimating()
                self?.presentDataCollectionView()
                self?.hideParameters()
                
            case .error(let error):
                self?.promptStackView.isHidden = true
                self?.resultsCollectionView.isHidden = true
                self?.activityIndicator.stopAnimating()
                self?.presentSimpleAlert(title: "Error", message: error)
            }
        }
    }
    
    private func showParameters() {
        promptStackView.isHidden = false
        categoriesStackView.isHidden = false
        limitStackView.isHidden = false
        
        resultsCollectionView.isHidden = true
        
        activityIndicator.stopAnimating()
    }
    
    private func hideParameters() {
        promptStackView.isHidden = true
        categoriesStackView.isHidden = true
        limitStackView.isHidden = true
        
        resultsCollectionView.isHidden = false
    }
    
    private func presentMockCollectionView() {
        resultsCollectionView.presentMockSkeleton()
        resultsCollectionView.reloadData()
        resultsCollectionView.alpha = 0.5
    }
    
    private func presentDataCollectionView() {
        resultsCollectionView.alpha = 1
        resultsCollectionView.reloadData()
    }
    
    private func startActivityAnimation() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

//MARK: - LimitDelegate

extension SearchViewController: LimitDelegate {
    func didSelect(limit: Int) {
        searchParameters.limit = limit
    }
}

//MARK: - CategoriesDelegate

extension SearchViewController: CategoriesDelegate {
    func didSelect(types: [EntityType]) {
        searchParameters.entity = types
    }
}

//MARK: - PromptDelegate

extension SearchViewController: PromptDelegate {
    func didSelect(title: String) {
        searchTextField.text = title
        promptStackView.isHidden = true
    }
}

//MARK: - SearchTextFieldDelegate

extension SearchViewController: SearchTextFieldDelegate {

    func search(text: String) { //При нажатии кнопки НАЙТИ на клавиатуре
        searchParameters.text = text
        viewModel.loadData(searchParameters)
        viewModel.saveRequestName(text)
        hideParameters()
    }
    
    func clear() {
        viewModel.cancelRequest()
        showParameters()
    }
    
    func typing(text: String) {
        let lastRequestNames = viewModel.getFiltredRequestNames(text)
        promptStackView.addPrompt(prompt: lastRequestNames)
    }
    
    func didBeginEditing() {
        showParameters()
    }
}

//MARK: - ResultsCollectionViewDelegate
extension SearchViewController: ResultsCollectionViewDelegate {
    func selectItem(indexPath: IndexPath) {
        print(indexPath)
    }
}

//MARK: - Configure

private extension SearchViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        configureSearchTextField()
        configureResultCollectionView()
        configureCategoriesStackView()
        configureLimitStackView()
        configurePromptStackView()
        configureActivityIndicator()
    }
    
    func configureSearchTextField() {
        searchTextField.borderStyle = .roundedRect
        searchTextField.searchDelegate = self

        view.addSubview(searchTextField)
        
        topConstraint = searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        topConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureResultCollectionView() {
        view.addSubview(resultsCollectionView)
        resultsCollectionView.isHidden = true
        
        resultsCollectionView.resultDelegate = self
        
        NSLayoutConstraint.activate([
            resultsCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            resultsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            resultsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            resultsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureCategoriesStackView() {
        view.addSubview(categoriesStackView)
        categoriesStackView.categoriesDelegate = self
        
        NSLayoutConstraint.activate([
            categoriesStackView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            categoriesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoriesStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureLimitStackView() {
        view.addSubview(limitStackView)
        limitStackView.limitDelegate = self
        
        NSLayoutConstraint.activate([
            limitStackView.topAnchor.constraint(equalTo: categoriesStackView.bottomAnchor, constant: 10),
            limitStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            limitStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configurePromptStackView() {
        view.addSubview(promptStackView)
        promptStackView.isHidden = true
        promptStackView.promptDelegate = self

        NSLayoutConstraint.activate([
            promptStackView.topAnchor.constraint(equalTo: limitStackView.bottomAnchor, constant: 10),
            promptStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    func configureActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

