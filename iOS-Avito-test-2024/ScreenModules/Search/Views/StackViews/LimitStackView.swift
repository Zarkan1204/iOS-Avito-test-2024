//
//  LimitStackView.swift
//  iOS-Avito-test-2024


import UIKit

protocol LimitDelegate: AnyObject {
    func didSelect(limit: Int)
}

final class LimitStackView: UIStackView {
    
    weak var limitDelegate: LimitDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        fillStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillStackView() {
        EntityType.ELimit.allCases.forEach { type in
            let button = SelectButton(title: String(type.rawValue))
            addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            let buttonAction = UIAction { [weak self] _ in
                self?.limitDelegate?.didSelect(limit: type.rawValue)
                self?.subviews.forEach {
                    if let subviewButton = $0 as? SelectButton {
                        subviewButton.isActive = false
                    }
                }
                button.isActive = true
            }
            button.addAction(buttonAction, for: .touchUpInside)
        }
    }
}

//MARK: - Configure

private extension LimitStackView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = 5
    }
}


