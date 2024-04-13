//
//  LookUpCollectionView + FlowLayout.swift
//  iOS-Avito-test-2024


import UIKit

extension LookUpCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.height * 0.7,
               height: collectionView.frame.height - 20)
    }
}
