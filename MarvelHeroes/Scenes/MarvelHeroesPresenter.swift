//
//  MarvelHeroesPresenter.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import Foundation

class MarvelHeroesPresenter {
    
    weak var vc: MarvelHeroesViewController?
    
    func presentHeroCollection(results: [DefaultHeroesService.Response.Result]) {
        vc?.collectionViewModel.add(results)
    }
}
