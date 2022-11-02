//
//  MervelDefaultCell.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 28/10/2022.
//  
//


import UIKit
import Combine

class MarvelDefaultCell: UICollectionViewCell {
    private let imageDownloader: ImageServiceWorker?
    private var bag = Set<AnyCancellable>()
    static var identifier: String {
        return self.description()
    }
    
    override init(frame: CGRect) {
        imageDownloader = ImageServiceWorker()
        super.init(frame: frame)
        
        imageDownloader?.imageCacheWorker = ImageCacheWorker()
        imageDownloader?.downloadImageWorker = DownloadImageWorker()
        heroImageView.addSubview(progressIndicator)
        addSubview(contentStackView)
        progressIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
    }
    
    private lazy var contentStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [heroImageView, heroNameLabel])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = DefaultCellLayout.cornerRadius
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = DefaultCellLayout.cornerRadius
        return imageView
    }()
    
    private var progressIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var heroNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .condensed)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = .green
        return label
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            heroImageView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.8),
            
            progressIndicator.centerXAnchor.constraint(equalTo: heroImageView.centerXAnchor),
            progressIndicator.centerYAnchor.constraint(equalTo: heroImageView.centerYAnchor)
        ])
    }
        
    private func animateActivityView() {
        progressIndicator.startAnimating()
    }
    
    private func fetchImage(url: URL?) {
        guard let url = url else {
            return
        }
        imageDownloader?.downloadImage(for: url)
            .sink { image in
                self.progressIndicator.stopAnimating()
                self.heroImageView.image = image
            }.store(in: &bag)
    }
    
    func update(with imageUrl: URL?, title: String) {
        fetchImage(url: imageUrl)
        heroNameLabel.text = title
    }
}
