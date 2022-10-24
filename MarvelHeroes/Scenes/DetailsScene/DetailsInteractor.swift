//
//  DetailsInteractor.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import Foundation

class DetailsInteractor {
    
    var presenter: DetailsPresenter?
    var hero: DefaultHeroesService.Response.Result
    init(hero: DefaultHeroesService.Response.Result) {
        self.hero = hero
    }
    
    func fetchHerosDatails() {
        presenter?.show(hero)
    }
}
