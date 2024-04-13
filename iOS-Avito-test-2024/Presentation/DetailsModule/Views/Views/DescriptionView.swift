//
//  DescriptionView.swift
//  iOS-Avito-test-2024


import UIKit

final class DescriptionView: UIView {
    
    private let descriptionLabel = UILabel(text: "Description", font: .urbanistLight13(), textColor: .searchPink)
    private let descriptionTextLabel = UILabel(font: .urbanistLight11(), textColor: .searchBlack)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addDescription(text: String) {
        descriptionTextLabel.text = text
    }
}

//MARK: - Configure

private extension DescriptionView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureDescriptionLabel()
        configureDescriptionTextLabel()
    }
    
    func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configureDescriptionTextLabel() {
        descriptionTextLabel.numberOfLines = 20
        addSubview(descriptionTextLabel)
        
        NSLayoutConstraint.activate([
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

