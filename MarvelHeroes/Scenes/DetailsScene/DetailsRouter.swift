//
//  DetailsRouter.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import Foundation

final class DetailsRouter {
    private var sceneFactory: SceneFactory?
    
    weak var source: DetailsViewController?
    
    init(sceneFactory: SceneFactory?) {
        self.sceneFactory = sceneFactory
    }
}
