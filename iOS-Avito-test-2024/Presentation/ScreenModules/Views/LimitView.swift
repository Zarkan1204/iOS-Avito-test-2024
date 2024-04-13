//
//  LimitView.swift
//  iOS-Avito-test-2024


import UIKit

protocol LimitDelegate: AnyObject {
    func didSelect(limit: Int)
}

final class LimitView: UIView {
    
    weak var limitDelegate: LimitDelegate?
    
    private let limitLabel = UILabel(text: "Limit", font: .urbanistLight11(), textColor: .searchPink)
    private let limitStackView = UIStackView()
    
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
        EntityType.ELimit.allCases.forEach { type in
            let button = SelectButton(title: String(type.rawValue))
            limitStackView.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            let buttonAction = UIAction { [weak self] _ in
                self?.limitDelegate?.didSelect(limit: type.rawValue)
                self?.limitStackView.subviews.forEach {
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

private extension LimitView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureLimitLabel()
        configureLimitStackView()
    }
    
    func configureLimitLabel() {
        addSubview(limitLabel)

        NSLayoutConstraint.activate([
            limitLabel.topAnchor.constraint(equalTo: topAnchor),
            limitLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            limitLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureLimitStackView() {
        limitStackView.translatesAutoresizingMaskIntoConstraints = false
        limitStackView.axis = .horizontal
        limitStackView.spacing = 5
        limitStackView.distribution = .fill
        
        addSubview(limitStackView)
        
        NSLayoutConstraint.activate([
            limitStackView.topAnchor.constraint(equalTo: topAnchor),
            limitStackView.leadingAnchor.constraint(equalTo: limitLabel.trailingAnchor),
            limitStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            limitStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
