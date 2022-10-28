//
//  DetailsViewController .swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import UIKit
import Combine

protocol DetailsViewControllerOutput: AnyObject {
    func tryToFetchHerosDetailedInfo()
}

protocol DetailsViewControllerIntput: AnyObject {
    func show(_ hero: DefaultHeroesService.Response.Character,
              heroImage: UIImage)
    func show(comicsData: [AnyPublisher<DefaultHeroesService.Response.ComicsData, Error>])
}

final class DetailsViewController : UIViewController {
    private var disposalBag = Set<AnyCancellable>()

    var interactor: DetailsInteractor?
    var router: DetailsRouter?
    var customView: DetailsCustomView {
        self.view as! DetailsCustomView
    }
    private lazy var collectionViewModel: ComicsCollectionViewModel = ComicsCollectionViewModel(collectionView: customView.comicsCollectionView, cellReuseIdentifier: ComicsCollectionViewCell.identifier, parentVC: self)
    
    override func loadView() {
        super.loadView()
        self.view = DetailsCustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryToFetchHerosDetailedInfo()
        
        customView.comicsCollectionView.delegate = collectionViewModel
        customView.comicsCollectionView.dataSource = collectionViewModel.makeDataSource()
        customView.comicsViewModel = collectionViewModel
    }
}

extension DetailsViewController: DetailsViewControllerOutput {
    func tryToFetchHerosDetailedInfo() {
        interactor?.fetchHerosDatails()
    }
    
    func tryToFetchComics(items: [DefaultHeroesService.Response.ComicsItem]) {
        interactor?.getComics(items: items)
    }
}

extension DetailsViewController: DetailsViewControllerIntput {
    func show(_ hero: DefaultHeroesService.Response.Character,
              heroImage: UIImage) {
        customView.update(with: DetailsCustomViewModel(hero: hero, heroImg: heroImage))
        tryToFetchComics(items: hero.comics.items)
    }
    
    func show(comicsData: [AnyPublisher<DefaultHeroesService.Response.ComicsData, Error>]) {
        var result = [DefaultHeroesService.Response.Comics]()
        Publishers.MergeMany(comicsData)
            .sink(receiveCompletion: { status in
                if case let .failure(error) = status {
                    print(error)
                }
            }, receiveValue: { comicsData in
                if let comics = comicsData.data.results.first {
                    result.append(comics)
                    self.customView.comicsViewModel?.add([comics])
                }
            }).store(in: &disposalBag)
    }
}
