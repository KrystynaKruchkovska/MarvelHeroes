//
//  MarvelHeroesRouter.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import UIKit

protocol MainSceneRoutingLogic {
    func showDetailsVC(with hero: DefaultHeroesService.Response.Result)
}

final class MarvelHeroesRouter {
    
    private var sceneFactory: SceneFactory?
    
    weak var source: UIViewController?
    
    init(sceneFactory: SceneFactory?) {
        self.sceneFactory = sceneFactory
    }
}
extension MarvelHeroesRouter: MainSceneRoutingLogic {
    func showDetailsVC(with hero: DefaultHeroesService.Response.Result) {
        let detailsSceneFactory = DetailsSceneFactory()
        detailsSceneFactory.configurator = DetailsConfigurator(sceneFactory: detailsSceneFactory, hero: hero)

        let scene = detailsSceneFactory.makeScene()
        source?.navigationController?.pushViewController(scene, animated: true)
    }
}

