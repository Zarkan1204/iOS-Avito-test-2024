//
//  UIView + Extensions.swift
//  iOS-Avito-test-2024


import UIKit

extension UIView {
    
    func addShadow() {
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
