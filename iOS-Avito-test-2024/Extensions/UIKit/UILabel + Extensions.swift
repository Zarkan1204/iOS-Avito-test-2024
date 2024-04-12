//
//  UILabel + Extensions.swift
//  iOS-Avito-test-2024


import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont?, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
