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

    private var hero: DefaultHeroesService.Response.Result
    private var disposalBag = Set<AnyCancellable>()

    
    init(hero: DefaultHeroesService.Response.Result) {
        self.hero = hero
    }
    
    func fetchHerosDatails() {
        if let imageUrl = hero.getImageUrl() {
            imageWorker?.downloadImage(for: imageUrl)
                .receive(on: DispatchQueue.main)
            .sink { image in
                self.presenter?.show(self.hero, heroImage: image)
            }.store(in: &disposalBag)
        }
    }
}
