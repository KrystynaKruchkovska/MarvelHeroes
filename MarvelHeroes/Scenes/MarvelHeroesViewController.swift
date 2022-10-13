//
//  MarvelHeroesViewController.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import UIKit

class MarvelHeroesViewController: UIViewController {

    var interactor: MarvelHeroesInteractor?
    var router: MarvelHeroesRouter?
    lazy var collectionViewModel: MarvelColllectionViewModel = MarvelColllectionViewModel(collectionView: collectionView, cellReuseIdentifier: HeroCollectionViewCell.identifier)
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        interactor?.getHeroes()
        view.backgroundColor = .red
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Layout.estimatedCollectionViewItemSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: HeroCollectionViewCell.identifier)
        return collectionView
    }()
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = self.view.bounds
        collectionView.dataSource = collectionViewModel.makeDataSource()
        collectionView.delegate = collectionViewModel
    }
}

extension MarvelHeroesViewController {
    
    private enum Layout {
        static let estimatedCollectionViewItemSize = CGSize(width: 120, height: 200)
    }
}
