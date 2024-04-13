//
//  SelectButton.swift
//  iOS-Avito-test-2024


import UIKit

final class SelectButton: UIButton {
    
     var isActive: Bool = false {
        didSet {
            if self.isActive {
                layer.borderWidth = 2
                layer.borderColor = UIColor.searchBorderPink.cgColor
                backgroundColor = .searchBgPink
                setTitleColor(.white, for: .normal)
            } else {
                layer.borderWidth = 1
                layer.borderColor = UIColor.searchLightGray.cgColor
                backgroundColor = .searchBgLightGray
                setTitleColor(.searchDarkGray, for: .normal)
            }
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
        layer.borderColor = UIColor.searchLightGray.cgColor
        layer.borderWidth = 1
        backgroundColor = .searchBgLightGray
        titleLabel?.font = .urbanistLight13()
        setTitleColor(.searchDarkGray, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
