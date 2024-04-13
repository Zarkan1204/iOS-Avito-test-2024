//
//  SearchTextField.swift
//  iOS-Avito-test-2024


import UIKit

protocol SearchViewDelegate: AnyObject {
    func search(text: String)
    func clear()
    func typing(text: String)
    func didBeginEditing()
}

final class SearchView: UIView {
    
    weak var searchDelegate: SearchViewDelegate?
    
    let searchNameLabel = UILabel(font: .urbanistLight16(), textColor: .searchGray)
    let searchTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String) {
        searchTextField.text = text
    }
}

private extension SearchView {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureSearchNameLabel()
        configureSearchTextField()
    }
    
    func configureSearchNameLabel() {
        let attributedTextColor: NSAttributedString = "Apple Media Search"
            .attributedStringColor(["Apple"],
                                   color: UIColor.searchPink)
        searchNameLabel.attributedText = attributedTextColor
        searchNameLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(searchNameLabel)
        
        NSLayoutConstraint.activate([
            searchNameLabel.topAnchor.constraint(equalTo: topAnchor),
            searchNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureSearchTextField() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
        searchTextField.clearButtonMode = .always
        searchTextField.borderStyle = .none
        searchTextField.layer.borderColor = UIColor.searchLightGray.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 10
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchTextField.leftViewMode = .always

        addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchNameLabel.bottomAnchor, constant: 2),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { 
        endEditing(true)
        guard let text = textField.text else { return true }
        searchDelegate?.search(text: text)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchDelegate?.clear()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            searchDelegate?.typing(text: updatedText)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchDelegate?.didBeginEditing()
    }
}
