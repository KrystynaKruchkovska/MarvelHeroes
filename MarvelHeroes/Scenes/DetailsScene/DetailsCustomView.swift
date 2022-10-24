//
//  DetailsCustomView.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import UIKit

final class DetailsCustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [heroImgView, descriptionLabel])
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

            heroImgView.widthAnchor.constraint(equalToConstant: 150),
            heroImgView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func update(with viewModel: DetailsCustomViewModel) {
        descriptionLabel.text = viewModel.description
        heroImgView.image = viewModel.heroImage
    }
}


class DetailsCustomViewModel {
    let description: String
    let heroImage: UIImage
    
    init(hero: DefaultHeroesService.Response.Result,
         heroImg: UIImage) {
        self.description = hero.description
        self.heroImage = heroImg
    }
    
}
