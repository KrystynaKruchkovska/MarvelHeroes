//
//  MarvelHeroesInteractor.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import Foundation

class MarvelHeroesInteractor {
    
    var presenter: MarvelHeroesPresenter?
    var heroesListWorker: HeroesListWorker?
    
    func getHeroes() {
        heroesListWorker?.fetchHeroes()
    }
}
