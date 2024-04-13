//
//  DetailViewController.swift
//  iOS-Avito-test-2024


import UIKit

final class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModelProtocol
    
    private let mainInfoView = MainInfoView()
    private let descriptionView = DescriptionView()
    private let collectionsLabel = UILabel(text: "Collections", font: .urbanistLight13(), textColor: .searchPink)
    private let lookUpCollectionView = LookUpCollectionView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private var collectionTopConstraint = NSLayoutConstraint()
    
    init(viewModel: DetailViewModelProtocol) {
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
            guard let state, let self else { return }
            switch state {
            case .initial(let item):
                self.mainInfoView.configure(item: item)
                if let text = item.description, !text.isEmpty {
                    self.descriptionView.isHidden = false
                    let descriptionText = text.convertHtml().string
                    self.descriptionView.addDescription(text: descriptionText)
                } else {
                    self.collectionTopConstraint = collectionsLabel.topAnchor.constraint(
                        equalTo: mainInfoView.bottomAnchor,
                        constant: 10)
                    self.collectionTopConstraint.isActive = true
                }
            case .loading:
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            case .success(let dataSource):
                activityIndicator.stopAnimating()
                if !dataSource.isEmpty {
                    self.lookUpCollectionView.cellDataSource = dataSource
                    self.lookUpCollectionView.reloadData()
                    self.showCollections()
                }
            case .error(let error):
                self.presentSimpleAlert(title: "Error", message: error)
            }
        }
    }
 
    private func showCollections() {
        collectionsLabel.isHidden = false
        lookUpCollectionView.isHidden = false
    }
}

//MARK: - LookUpProtocol

extension DetailViewController: LookUpProtocol {
    func didSelect(urlStr: String) {
        guard let targetURL = NSURL(string: urlStr) as? URL else { return }
        let application = UIApplication.shared
        application.open(targetURL)
    }
}

//MARK: -

extension DetailViewController: MainInfoProtocol {
    func openLink(urlStr: String) {
        guard let targetURL = NSURL(string: urlStr) as? URL else { return }
        let application = UIApplication.shared
        application.open(targetURL)
    }
}

//MARK: - Configure

private extension DetailViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        configureMainInfoView()
        configureDescriptionView()
        configureCollectionsLabel()
        configureActivityIndicator()
        configureLookUpCollectionView()
    }
    
    func configureMainInfoView() {
        mainInfoView.mainInfoDelegate = self
        
        view.addSubview(mainInfoView)
        
        NSLayoutConstraint.activate([
            mainInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            mainInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureDescriptionView() {
        descriptionView.isHidden = true

        view.addSubview(descriptionView)

        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: mainInfoView.bottomAnchor, constant: 10),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func configureCollectionsLabel() {

        collectionsLabel.isHidden = true
        view.addSubview(collectionsLabel)
        
        collectionTopConstraint = collectionsLabel.topAnchor.constraint(
            equalTo: descriptionView.bottomAnchor,
            constant: 10)
        collectionTopConstraint.isActive = true

        NSLayoutConstraint.activate([
            collectionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func configureLookUpCollectionView() {
        lookUpCollectionView.isHidden = true
        lookUpCollectionView.lookUpDelegate = self
        view.addSubview(lookUpCollectionView)
        
        NSLayoutConstraint.activate([
            lookUpCollectionView.topAnchor.constraint(equalTo: collectionsLabel.bottomAnchor),
            lookUpCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lookUpCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lookUpCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45)
        ])
    }
    
    func configureActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 20),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
