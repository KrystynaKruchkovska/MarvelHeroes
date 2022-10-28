//
//  DetailsPresenter.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import UIKit
import Combine

final class DetailsPresenter {
    weak var vc: DetailsViewController?
    
    func show(_ hero: DefaultHeroesService.Response.Character, heroImage: UIImage) {
        vc?.show(hero, heroImage: heroImage)
    }
    
    func show(comicsData: [AnyPublisher<DefaultHeroesService.Response.ComicsData, Error>]) {
        vc?.show(comicsData: comicsData)
    }
}
