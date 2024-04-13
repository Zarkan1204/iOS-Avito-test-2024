//
//  ResultsCollectionViewCell.swift
//  iOS-Avito-test-2024


import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {
    
    private let previewImageView = UIImageView()
    private let backView = UIView()
    private let nameLabel = UILabel(font: .urbanistRegular12(), textColor: .searchBlack)
    private let artistNameLabel = UILabel(font: .urbanistLight11(), textColor: .searchGray)
    private let releaseDateLabel = UILabel(font: .urbanistLight11(), textColor: .searchGray)
    private let typeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: CollectionItem) {
        
        nameLabel.text = model.name.capitalized
        artistNameLabel.text = model.artistName.capitalized
        releaseDateLabel.text = model.releaseDate
        typeImageView.image = UIImage(systemName: model.type)

        guard let data = model.preview else {
            previewImageView.image = UIImage()
            return
        }
        let image = UIImage(data: data)
        previewImageView.image = image
    }
}

//MARK: - Configure
private extension ResultsCollectionViewCell {
    
    func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = .white
        addShadow()
        
        configurePreviewImageView()
        configureBackView()
        configureNameLabel()
        configureArtistNameLabel()
        configureReleaseDateLabel()
        configureTypeImageView()
    }
    
    func configurePreviewImageView() {
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.layer.cornerRadius = 10
        previewImageView.clipsToBounds = true
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(previewImageView)
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewImageView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func configureBackView() {
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backView)
        backView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        NSLayoutConstraint.activate([
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    func configureNameLabel() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
        ])
    }
    
    func configureArtistNameLabel() {
        addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            artistNameLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            artistNameLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
        ])
    }
    
    func configureReleaseDateLabel() {
        addSubview(releaseDateLabel)
        
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 2),
            releaseDateLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            releaseDateLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
        ])
    }
    
    func configureTypeImageView() {
        typeImageView.layer.cornerRadius = 15
        typeImageView.tintColor = .searchPink
        typeImageView.backgroundColor = .white
        typeImageView.translatesAutoresizingMaskIntoConstraints = false
        typeImageView.alpha = 0.8
        
        addSubview(typeImageView)
        
        NSLayoutConstraint.activate([
            typeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            typeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            typeImageView.heightAnchor.constraint(equalToConstant: 30),
            typeImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

//MARK: - Reusable
extension ResultsCollectionViewCell: Reusable {}
