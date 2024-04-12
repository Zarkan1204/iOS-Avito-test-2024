//
//  SelectButton.swift
//  iOS-Avito-test-2024


import UIKit

final class SelectButton: UIButton {
    
     var isActive: Bool = false {
        didSet {
            layer.borderColor = isActive ? UIColor.systemPink.cgColor : UIColor.lightGray.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init()
        setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

