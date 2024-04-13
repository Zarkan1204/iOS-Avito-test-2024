//
//  SearchViewController.swift
//  iOS-Avito-test-2024


import UIKit

protocol SearchCoordinatorProtocol: AnyObject {
    func didSelect(item: CollectionItem)
}

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModelProtocol
    private weak var coordinator: SearchCoordinatorProtocol?

    private let searchView = SearchView()
    private let promptStackView = PromptStackView()
    private let resultsCollectionView = ResultCollectionView()
    private let entityView = EntityView()
    private let limitView = LimitView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private var topConstraint = NSLayoutConstraint()
    private var searchParameters = SearchParameters() 
    
    init(coordinator: SearchCoordinatorProtocol, viewModel: SearchViewModelProtocol) {
        self.coordinator = coordinator
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
        entityView.isHidden = false
        limitView.isHidden = false
        
        resultsCollectionView.isHidden = true
        
        activityIndicator.stopAnimating()
    }
    
    private func hideParameters() {
        promptStackView.isHidden = true
        entityView.isHidden = true
        limitView.isHidden = true
        
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

extension SearchViewController: EntityDelegate {
    func didSelect(types: [EntityType]) {
        searchParameters.entity = types
    }
}

//MARK: - PromptDelegate

extension SearchViewController: PromptDelegate {
    func didSelect(title: String) {
        searchView.setText(text: title)
        promptStackView.isHidden = true
    }
}

//MARK: - SearchTextFieldDelegate

extension SearchViewController: SearchViewDelegate {

    func search(text: String) { 
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
        let selectItem = resultsCollectionView.cellDataSource[indexPath.row]
        coordinator?.didSelect(item: selectItem)
    }
}

//MARK: - Configure

private extension SearchViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        configureSearchView()
        configureResultCollectionView()
        configureEntityView()
        configureLimitView()
        configurePromptStackView()
        configureActivityIndicator()
    }
    
    func configureSearchView() {
        searchView.searchDelegate = self

        view.addSubview(searchView)
        
        topConstraint = searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        topConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func configureResultCollectionView() {
        view.addSubview(resultsCollectionView)
        resultsCollectionView.isHidden = true
        
        resultsCollectionView.resultDelegate = self
        
        NSLayoutConstraint.activate([
            resultsCollectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
            resultsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            resultsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            resultsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureEntityView() {
        view.addSubview(entityView)
        entityView.categoriesDelegate = self
        
        NSLayoutConstraint.activate([
            entityView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            entityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            entityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            entityView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureLimitView() {
        view.addSubview(limitView)
        limitView.limitDelegate = self
        
        NSLayoutConstraint.activate([
            limitView.topAnchor.constraint(equalTo: entityView.bottomAnchor, constant: 10),
            limitView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            limitView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            limitView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configurePromptStackView() {
        view.addSubview(promptStackView)
        promptStackView.isHidden = true
        promptStackView.promptDelegate = self

        NSLayoutConstraint.activate([
            promptStackView.topAnchor.constraint(equalTo: limitView.bottomAnchor, constant: 10),
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
            activityIndicator.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

