//
//  DetailsInteractor.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import Foundation
import Combine

final class DetailsInteractor {
    
    var presenter: DetailsPresenter?
    var imageWorker: ImageServiceProtocol?
    var heroDetailsWorker: HeroDetailsWorkerProtocol?
    
    private var hero: DefaultHeroesService.Response.Character
    private var disposalBag = Set<AnyCancellable>()
    
    
    init(hero: DefaultHeroesService.Response.Character) {
        self.hero = hero
    }
    
    func fetchHerosDatails() {
        if let imageUrl = hero.thumbnail.getImageUrl() {
            imageWorker?.downloadImage(for: imageUrl)
                .receive(on: DispatchQueue.main)
                .sink { image in
                    self.presenter?.show(self.hero, heroImage: image)
                }.store(in: &disposalBag)
        }
    }
    
    func getComics(items: [DefaultHeroesService.Response.ComicsItem]) {
        let myresult =  items.compactMap { item in
            if let path = item.resourceURI.components(separatedBy: "/").last {
                let endpoint  = MarvelHeroesEndpoint.getComics(lastPathComponent: path)
                return heroDetailsWorker?.fetchComics(endpoint: endpoint)
                    .eraseToAnyPublisher()
                
            } else {
                return nil
            }
        }
        presenter?.show(comicsData: myresult)
    }
}

