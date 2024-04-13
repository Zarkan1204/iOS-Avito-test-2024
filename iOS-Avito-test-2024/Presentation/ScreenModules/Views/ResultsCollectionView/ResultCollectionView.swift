//
//  ResultCollectionView.swift
//  iOS-Avito-test-2024


import UIKit

protocol ResultsCollectionViewDelegate: AnyObject {
    func selectItem(indexPath: IndexPath)
}

class ResultCollectionView: UICollectionView {
    
    weak var resultDelegate: ResultsCollectionViewDelegate?
    
    var cellDataSource = [CollectionItem]()
    
    private let collectionLayout = UICollectionViewFlowLayout()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        layoutConfigure()
        setDelegates()
        
        register(ResultsCollectionViewCell.self,
                 forCellWithReuseIdentifier: ResultsCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentMockSkeleton() {
        let collectionItem = CollectionItem(name: "----------",
                                            type: "circle.badge.questionmark",
                                            releaseDate: "------",
                                            artistName: "--------",
                                            preview: nil,
                                            description: "",
                                            trackViewUrl: "")
        cellDataSource = Array(repeating: collectionItem, count: 6)
    }
}

//MARK: - Congifure

private extension ResultCollectionView {
    
    private func configure() {
        backgroundColor = .none
        bounces = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutConfigure() {
        collectionLayout.minimumInteritemSpacing = .zero
        collectionLayout.minimumLineSpacing = 10
        collectionLayout.sectionInset = UIEdgeInsets(top: .zero,
                                           left: 5,
                                           bottom: .zero,
                                           right: 5)
    }

    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}
