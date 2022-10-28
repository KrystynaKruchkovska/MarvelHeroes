//
//  DetailsCustomView.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import UIKit

final class DetailsCustomView: UIView {
    var comicsViewModel: ComicsCollectionViewModel?
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .red
        self.addSubview(stackView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var heroImgView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .condensed)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .condensed)
        return label
    }()
    
    private (set) lazy var comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = DefaultCellLayout.collectionViewItemSize

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: ComicsCollectionViewCell.identifier)
        return collection
    }()
    
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [heroImgView,nameLabel,descriptionLabel, comicsCollectionView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            heroImgView.widthAnchor.constraint(equalToConstant: 300),
            heroImgView.heightAnchor.constraint(equalToConstant: 300),
            comicsCollectionView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
            comicsCollectionView.heightAnchor.constraint(equalToConstant: DefaultCellLayout.characterImageHeight)
        ])
    }
    
    func update(with viewModel: DetailsCustomViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        heroImgView.image = viewModel.image
    }
}


class DetailsCustomViewModel {
    private let hero: DefaultHeroesService.Response.Character
    
    let image: UIImage
    
    var description: String {
        hero.description
    }
    var name: String {
        return hero.name
    }

    init(hero: DefaultHeroesService.Response.Character,
         heroImg: UIImage) {
        self.hero = hero
        self.image = heroImg
    }
}
