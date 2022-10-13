//
//  HeroCollectionViewCell.swift
//  MarvelHeroes
//
//  Created by Paweł on 13/10/2022.
//

import UIKit

protocol Providable {
    associatedtype ProvidedItem: Hashable
    func provide(_ item: ProvidedItem)
}

final class HeroCollectionViewCell: UICollectionViewCell, Providable {
    
    typealias ProvidedItem = DefaultHeroesService.Response.Result
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
        return stackView
    }()
    
    private var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Layout.cornerRadius
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private var heroNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
            heroImageView.widthAnchor.constraint(equalToConstant: Layout.characterImageWidth),
        ])
    }
    
    func provide(_ item: ProvidedItem) {
        heroImageView.image = fetchImage(strUrl: "item.thumbnail.path")
        heroNameLabel.text = item.name
    }
    
    func fetchImage(strUrl: String) -> UIImage? {
        return UIImage(named: "square.and.arrow.up.fill")
    }
}
