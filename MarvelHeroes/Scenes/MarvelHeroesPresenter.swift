//
//  MarvelHeroesPresenter.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import Foundation

class MarvelHeroesPresenter {
    
    weak var vc: MarvelHeroesViewController?
    
    func showFetchedHeroes(results: [DefaultHeroesService.Response.Result]) {
        vc?.showFetchedHeroes(results)
    }
    
    func showFetchedHeroesFailure(message: String) {
        vc?.showFetchedHeroesFailure(message: message)
    }
}
