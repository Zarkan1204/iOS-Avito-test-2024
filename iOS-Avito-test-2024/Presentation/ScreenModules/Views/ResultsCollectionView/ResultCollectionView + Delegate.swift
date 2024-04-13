//
//  ResultCollectionView + Delegate.swift
//  iOS-Avito-test-2024


import UIKit

extension ResultCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resultDelegate?.selectItem(indexPath: indexPath)
    }
}
