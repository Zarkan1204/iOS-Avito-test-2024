//
//  LookUpCollectionView + DataSource.swift
//  iOS-Avito-test-2024


import UIKit

extension LookUpCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LookUpCollectionViewCell.reuseIdentifier,
            for: indexPath) as? LookUpCollectionViewCell
        
        let model = cellDataSource[indexPath.row]
        cell?.configure(model: model)
        
        return cell ?? ResultsCollectionViewCell()
    }
}
