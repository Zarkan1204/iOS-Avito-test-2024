//
//  ResultCollectionView + DataSource.swift
//  iOS-Avito-test-2024


import UIKit

extension ResultCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ResultsCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ResultsCollectionViewCell
        
        let model = cellDataSource[indexPath.row]
        cell?.configure(model: model)
        
        return cell ?? ResultsCollectionViewCell()
    }
}
