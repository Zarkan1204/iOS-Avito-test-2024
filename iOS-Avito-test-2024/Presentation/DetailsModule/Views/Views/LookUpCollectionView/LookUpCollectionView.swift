//
//  LookUpCollectionView.swift
//  iOS-Avito-test-2024


import UIKit

protocol LookUpProtocol: AnyObject {
    func didSelect(urlStr: String)
}

class LookUpCollectionView: UICollectionView {
    
    weak var lookUpDelegate: LookUpProtocol?
 
    var cellDataSource = [LookUpItem]()
    
    private let collectionLayout = UICollectionViewFlowLayout()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        layoutConfigure()
        setDelegates()

        register(LookUpCollectionViewCell.self,
                 forCellWithReuseIdentifier: LookUpCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Congifure

private extension LookUpCollectionView {
    
    private func configure() {
        backgroundColor = .none
        bounces = false
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutConfigure() {
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.sectionInset = UIEdgeInsets(top: .zero,
                                                     left: 10,
                                                     bottom: .zero,
                                                     right: 10)
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}
