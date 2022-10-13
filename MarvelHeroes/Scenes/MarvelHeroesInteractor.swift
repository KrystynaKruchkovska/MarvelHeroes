//
//  MarvelHeroesInteractor.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import Foundation
import Combine

class MarvelHeroesInteractor {
    
    var presenter: MarvelHeroesPresenter?
    var heroesListWorker: HeroesListWorker?
    private var disposalBag = Set<AnyCancellable>()
    
    func getHeroes() {
        heroesListWorker?.fetchHeroes()
            .sink(receiveCompletion: {
                status in
                print("STATTUS: \(status)")
            }, receiveValue: { [weak self] response in
                self?.presenter?.presentHeroCollection(results: response.data.results)
            })
            .store(in: &disposalBag)
    }
}
