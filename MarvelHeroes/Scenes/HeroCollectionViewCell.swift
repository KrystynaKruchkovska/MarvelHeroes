//
//  HeroCollectionViewCell.swift
//  MarvelHeroes
//
//  Created by Paweł on 13/10/2022.
//

import UIKit
import Combine

protocol Providable {
    associatedtype ProvidedItem: Hashable
    func provide(_ item: ProvidedItem)
}

final class HeroCollectionViewCell: UICollectionViewCell, Providable {
    
    typealias ProvidedItem = DefaultHeroesService.Response.Result
    private let imageDownloader: ImageDownloaderManager?
    private var bag = Set<AnyCancellable>()
    static var identifier: String {
        return self.description()
    }
    
    private enum Layout {
        static var cornerRadius: CGFloat = 5
        static let characterImageHeight: CGFloat = 180
        static let characterImageWidth: CGFloat = 120
    }
    
    override init(frame: CGRect) {
        imageDownloader = ImageDownloaderManager()
        super.init(frame: frame)
        
        contentStackView.frame = self.bounds
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
        heroImageView.image = nil
    }
    
    private lazy var contentStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [heroImageView, heroNameLabel])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = Layout.cornerRadius
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = Layout.cornerRadius
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private var progressIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .purple
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
            heroImageView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.8),
            progressIndicator.centerXAnchor.constraint(equalTo: heroImageView.centerXAnchor),
            progressIndicator.centerYAnchor.constraint(equalTo: heroImageView.centerYAnchor)
        ])
    }
    
    func provide(_ item: ProvidedItem) {
        fetchImage(strUrl:item.thumbnail.path + "." +
                   item.thumbnail.thumbnailExtension.rawValue)
        heroNameLabel.text = item.name
    }
    
    private func fetchImage(strUrl: String) {
        guard var comps = URLComponents(string: strUrl) else {
            return
        }
        comps.scheme = "https"
        guard let url = comps.url else {
            return
        }
        
        imageDownloader?.downloadImage(for: url)
            .sink { image in
                self.progressIndicator.stopAnimating()
                self.heroImageView.image = image
            }.store(in: &bag)
    }
}


