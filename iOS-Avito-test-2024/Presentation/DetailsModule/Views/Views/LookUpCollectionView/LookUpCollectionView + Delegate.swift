//
//  LookUpCollectionView + Delegate.swift
//  iOS-Avito-test-2024


import Foundation
import UIKit

extension LookUpCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let urlStr = cellDataSource[indexPath.row].collectionViewUrl else { return }
        lookUpDelegate?.didSelect(urlStr: urlStr)
    }
}
