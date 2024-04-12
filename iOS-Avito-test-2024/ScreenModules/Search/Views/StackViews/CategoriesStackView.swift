//
//  CategoriesStackView.swift
//  iOS-Avito-test-2024


import UIKit

protocol CategoriesDelegate: AnyObject {
    func didSelect(types: [EntityType])
}

final class CategoriesStackView: UIStackView {
    
    weak var categoriesDelegate: CategoriesDelegate?
    private var selectTypes = [EntityType]()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        fillStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillStackView() {
        EntityType.allCases.forEach { type in
            let button = SelectButton(title: type.rawValue)
            addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
 
            let buttonAction = UIAction { [weak self] _ in
                guard let self else { return }
                button.isActive = !button.isActive
                
                if button.isActive {
                    self.selectTypes.append(type)
                } else {
                    self.selectTypes.removeAll(where: { $0 == type })
                }
                self.categoriesDelegate?.didSelect(types: self.selectTypes)
            }
            button.addAction(buttonAction, for: .touchUpInside)
        }
    }
}

//MARK: - Configure

private extension CategoriesStackView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        spacing = 5
    }
}

