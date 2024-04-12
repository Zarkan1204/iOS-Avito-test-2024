//
//  UIViewController + Extensions.swift
//  iOS-Avito-test-2024


import UIKit

extension UIViewController {
    
    func presentSimpleAlert(title: String, message: String? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okButton)
        
        present(alertController, animated: true)
    }
}
