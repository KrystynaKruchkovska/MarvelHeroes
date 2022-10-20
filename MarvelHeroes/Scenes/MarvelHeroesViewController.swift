//
//  MarvelHeroesViewController.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import UIKit


protocol MarvelHeroesViewControllerInput: AnyObject {
    func showFetchedHeroes(_ results: [DefaultHeroesService.Response.Result])
    func showFetchedHeroesFailure(message: String)
}

protocol MarvelHeroesViewControllerOutput: AnyObject {
    func tryToFetchHeroes()
}

class MarvelHeroesViewController: UIViewController {

    var interactor: MarvelHeroesInteractor?
    var router: MarvelHeroesRouter?
    private lazy var collectionViewModel: MarvelColllectionViewModel = MarvelColllectionViewModel(collectionView: collectionView, cellReuseIdentifier: HeroCollectionViewCell.identifier, parentVC: self)
    
    private var alert: InfoAlert
    private let emptyCollectionLabel = makeDefaultLabel()
    
    init() {
        self.alert = DefaultInfoAlert()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        tryToFetchHeroes()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Layout.estimatedCollectionViewItemSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: HeroCollectionViewCell.identifier)
        return collectionView
    }()
    
    private func configureView() {
        self.navigationController?.navigationBar.topItem?.title = "Marvel"
        configureCollectionView()
    }
    private func configureCollectionView() {
        view.addSubview(collectionView)
        setupConstraints()
        collectionView.dataSource = collectionViewModel.makeDataSource()
        collectionView.delegate = collectionViewModel
        emptyCollectionLabel.text = "Not possible to load data"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private static func makeDefaultLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension MarvelHeroesViewController {
    private enum Layout {
        static let estimatedCollectionViewItemSize = CGSize(width: 120, height: 200)
    }
}
extension MarvelHeroesViewController: MarvelHeroesViewControllerOutput {
    func tryToFetchHeroes() {
        interactor?.getHeroes()
    }
}

extension MarvelHeroesViewController: MarvelHeroesViewControllerInput {
    func showFetchedHeroesFailure(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self =  self else {
                return
            }
            if self.collectionView.visibleCells.count > 0 {
                self.alert.show(on: self,  message: message, acceptanceCompletion: nil)
            } else {
                self.collectionView.backgroundView = self.emptyCollectionLabel
            }
        }
    }

    func showFetchedHeroes(_ results: [DefaultHeroesService.Response.Result]) {
        collectionViewModel.add(results)
    }
}
