//
//  ResultCollectionView + DelegateFlowLayout.swift
//  iOS-Avito-test-2024


import UIKit

extension ResultCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2 - 10,
               height: collectionView.frame.width / 1.8)
    }
}
