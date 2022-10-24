//
//  DetailsPresenter.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import UIKit

final class DetailsPresenter {
    weak var vc: DetailsViewController?
    
    func show(_ hero: DefaultHeroesService.Response.Result, heroImage: UIImage) {
        vc?.show(hero, heroImage: heroImage)
    }
}
