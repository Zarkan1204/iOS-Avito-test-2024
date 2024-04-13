//
//  LookUpCollectionViewCell.swift
//  iOS-Avito-test-2024


import UIKit

class LookUpCollectionViewCell: UICollectionViewCell {
    
    private let previewImageView = UIImageView()
    private let infoStackView = UIStackView()
    private let nameLabel = UILabel(font: .boldSystemFont(ofSize: 10), textColor: .black)
    private let releaseDateLabel = UILabel(font: .systemFont(ofSize: 10), textColor: .black)
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: LookUpItem) {
        nameLabel.text = model.collectionName
        releaseDateLabel.text = model.releaseDate?.convertData()

        guard let data = model.preview else { return }
        previewImageView.image = UIImage(data: data)
    }
}

//MARK: - Configure
private extension LookUpCollectionViewCell {
    
    func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = .white
        addShadow()
        
        configurePreviewImageView()
        configureInfoStackView()
    }
    
    func configurePreviewImageView() {
        previewImageView.layer.cornerRadius = 10
        previewImageView.clipsToBounds = true
        previewImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.contentMode = .scaleAspectFit
        
        addSubview(previewImageView)
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            previewImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
    
    func configureInfoStackView() {
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.textColor = .lightGray
        
        infoStackView.axis = .vertical
        infoStackView.spacing = -10
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        [nameLabel, releaseDateLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 5),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - Reusable
extension LookUpCollectionViewCell: Reusable {}


