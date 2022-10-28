//
//  MarvelHeroesPresenter.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import Foundation

class MarvelHeroesPresenter {
    
    weak var vc: MarvelHeroesViewController?
    
    func showFetchedHeroes(results: [DefaultHeroesService.Response.Character]) {
        vc?.showFetchedHeroes(results)
    }
    
    func showFetchedHeroesFailure(message: String) {
        vc?.showFetchedHeroesFailure(message: message)
    }
}
