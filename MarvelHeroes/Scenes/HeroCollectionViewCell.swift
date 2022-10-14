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
    
    //    weak var viewController: MarvelHeroesViewController?
    
    // TODO : DELETE IT
    let interactor = MarvelHeroesInteractor()
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
        super.init(frame: frame)
        contentStackView.frame = self.bounds
        interactor.imageCacheWorker = ImageCacheWorker()
        interactor.downloadImageWorker = DownloadImageWorker()
        addSubview(contentStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private lazy var contentStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [heroImageView, heroNameLabel])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = Layout.cornerRadius
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
            heroImageView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.8)
        ])
    }
    
    func provide(_ item: ProvidedItem) {
        fetchImage(strUrl:item.thumbnail.path + "." +
                   item.thumbnail.thumbnailExtension.rawValue)
        heroNameLabel.text = item.name
    }
    
    func fetchImage(strUrl: String) {
        
        guard var comps = URLComponents(string: strUrl) else {
            return
        }
        comps.scheme = "https"
     
        guard let url = comps.url else {
            return
        }
        interactor.downloadImage(for: url)
            .sink { image in
                self.heroImageView.image = image
            }.store(in: &bag)
        
    }
}


