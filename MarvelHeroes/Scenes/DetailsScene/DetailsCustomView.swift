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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubview(stackView)
        updateStackView(with: frame.size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private var heroImgView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = DefaultCellLayout.cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return imageView
    }()
    
    private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .condensed)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .condensed)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private (set) lazy var comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        collection.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: ComicsCollectionViewCell.identifier)
        return collection
    }()
    
    
    private lazy var imageStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [heroImgView,nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [imageStackView,descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [topStackView, comicsCollectionView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    private func setupLayout() {
        
        let collectionHeight = comicsCollectionView.heightAnchor.constraint(equalToConstant: DefaultCellLayout.characterImageHeight)
        collectionHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            heroImgView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            heroImgView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            comicsCollectionView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
//            comicsCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: DefaultCellLayout.characterImageHeight),
            collectionHeight
        ])
    }
    
    func update(with viewModel: DetailsCustomViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        heroImgView.image = viewModel.image
    }
    
    func updateStackView(with size: CGSize) {
        
        let orintation  = UIDevice.current.orientation

        if case .portrait = orintation {
            topStackView.axis = .vertical
            stackView.distribution = .fill
            comicsCollectionView.reloadData()
            self.comicsCollectionView.layoutIfNeeded()
        } else {
            imageStackView.distribution = .fill
            topStackView.axis = .horizontal
            topStackView.distribution = .fillEqually
            stackView.distribution = .fillEqually

            comicsCollectionView.reloadData()
            self.comicsCollectionView.layoutIfNeeded()
        }
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
