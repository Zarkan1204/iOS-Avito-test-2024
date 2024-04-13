//
//  EntityView.swift
//  iOS-Avito-test-2024


import UIKit

protocol EntityDelegate: AnyObject {
    func didSelect(types: [EntityType])
}

final class EntityView: UIView {
    
    weak var categoriesDelegate: EntityDelegate?
    
    private let entityLabel = UILabel(text: "Entity", font: .urbanistLight11(), textColor: .searchPink)
    private let entityStackView = UIStackView()
    
    private var selectTypes = [EntityType]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        fillStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillStackView() {
        EntityType.allCases.forEach { type in
            let button = SelectButton(title: type.rawValue)
            entityStackView.addArrangedSubview(button)
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

private extension EntityView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureEntityLabel()
        configureEntityStackView()
    }
    
    func configureEntityLabel() {
        addSubview(entityLabel)

        NSLayoutConstraint.activate([
            entityLabel.topAnchor.constraint(equalTo: topAnchor),
            entityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            entityLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureEntityStackView() {
        entityStackView.translatesAutoresizingMaskIntoConstraints = false
        entityStackView.axis = .horizontal
        entityStackView.spacing = 5
        entityStackView.distribution = .fill
        
        addSubview(entityStackView)
        
        NSLayoutConstraint.activate([
            entityStackView.topAnchor.constraint(equalTo: topAnchor),
            entityStackView.leadingAnchor.constraint(equalTo: entityLabel.trailingAnchor),
            entityStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            entityStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

