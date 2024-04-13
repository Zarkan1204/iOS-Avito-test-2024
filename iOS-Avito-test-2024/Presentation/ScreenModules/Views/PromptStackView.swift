//
//  PromptStackView.swift
//  iOS-Avito-test-2024


import UIKit

protocol PromptDelegate: AnyObject {
    func didSelect(title: String)
}

final class PromptStackView: UIStackView {
    
    weak var promptDelegate: PromptDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addPrompt(prompt: [String]) {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        prompt.forEach {
            let promptButton = createPromptButton(title: $0)
            addArrangedSubview(promptButton)
        }
        layoutIfNeeded()
    }
    
    private func createPromptButton(title: String) -> UIButton {
        let promptButton = UIButton()
        promptButton.layer.cornerRadius = 10
        promptButton.layer.borderWidth = 1
        promptButton.layer.borderColor = UIColor.searchLightGray.cgColor
        promptButton.frame.size = CGSize(width: frame.width,
                                         height: 30)
        promptButton.setTitle(title, for: .normal)
        promptButton.setTitleColor(.searchDarkGray, for: .normal)
        promptButton.titleLabel?.font = .urbanistLight13()

        let promptAction = UIAction { [weak self] _ in
            self?.promptDelegate?.didSelect(title: title)
        }
        promptButton.addAction(promptAction, for: .touchUpInside)
        return promptButton
    }
}

//MARK: - Configure

private extension PromptStackView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 5
    }
}
