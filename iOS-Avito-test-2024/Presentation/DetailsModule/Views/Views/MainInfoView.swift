//
//  MainInfoView.swift
//  iOS-Avito-test-2024


import UIKit

protocol MainInfoProtocol: AnyObject {
    func openLink(urlStr: String)
}

final class MainInfoView: UIView {
    
    weak var mainInfoDelegate: MainInfoProtocol?

    private let previewImageView = UIImageView()
    private let typeImageView = UIImageView()
    private let infoStackView = UIStackView()
    private let informationLabel = UILabel(text: "Information", font: .urbanistLight13(), textColor: .searchPink)
    private let nameLabel = UILabel(font: .urbanistBold12(), textColor: .searchBlack)
    private let artistNameLabel = UILabel(font: .urbanistRegular12(), textColor: .searchDarkGray)
    private let artistButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: CollectionItem) {
        nameLabel.text = item.name
        artistNameLabel.text = item.artistName
        typeImageView.image = UIImage(systemName: item.type)
        
        let buttonAction = UIAction { [weak self] _ in
            self?.mainInfoDelegate?.openLink(urlStr: item.trackViewUrl)
        }
        artistButton.addAction(buttonAction, for: .touchUpInside)
        
        guard let data = item.preview else { return }
        previewImageView.image = UIImage(data: data)
    }
}

private extension MainInfoView {
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        configurePreviewImageView()
        configureInformationLabel()
        configureInfoStackView()
        configureTypeImageView()
        configureArtistButton()
    }
    
    func configurePreviewImageView() {
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.clipsToBounds = true
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(previewImageView)
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            previewImageView.widthAnchor.constraint(equalTo: previewImageView.heightAnchor)
        ])
    }
    
    func configureTypeImageView() {
        typeImageView.contentMode = .scaleAspectFit
        typeImageView.tintColor = .searchPink
        typeImageView.backgroundColor = .white
        typeImageView.layer.cornerRadius = 15
        typeImageView.alpha = 0.8
        typeImageView.translatesAutoresizingMaskIntoConstraints = false
 
        addSubview(typeImageView)
        
        NSLayoutConstraint.activate([
            typeImageView.topAnchor.constraint(equalTo: previewImageView.topAnchor, constant: 5),
            typeImageView.trailingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: -5),
            typeImageView.widthAnchor.constraint(equalToConstant: 30),
            typeImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureInformationLabel() {
        
        addSubview(informationLabel)
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: topAnchor, constant: -5),
            informationLabel.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 10),
            informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func configureInfoStackView() {
        infoStackView.axis = .vertical
        infoStackView.spacing = 2
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        [nameLabel, artistNameLabel, artistButton].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func configureArtistButton() {
        artistButton.contentHorizontalAlignment = .left
        artistButton.titleLabel?.font = .systemFont(ofSize: 12)
        artistButton.setTitle("Watch on Apple TV", for: .normal)
    }
}
