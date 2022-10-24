//
//  MarvelHeroesRouter.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import UIKit

class MarvelHeroesRouter {
    
    private var sceneFactory: SceneFactory?
    
    weak var source: UIViewController?
    
    init(sceneFactory: SceneFactory?) {
        self.sceneFactory = sceneFactory
    }
}
