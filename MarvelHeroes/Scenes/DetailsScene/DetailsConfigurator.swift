//
//  DetailsConfigurator.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import UIKit

final class DetailsConfigurator: SceneConfigurator {
    
    private weak var sceneFactory: SceneFactory?
    private var hero: DefaultHeroesService.Response.Result
    
    init(sceneFactory: SceneFactory,
         hero: DefaultHeroesService.Response.Result) {
        self.sceneFactory = sceneFactory
        self.hero = hero
    }
    
    func configured<T>(_ vc: T) -> T where T : UIViewController {
        guard let vc = vc as? DetailsViewController else {
            fatalError()
        }
        
        let interactor = DetailsInteractor(hero: hero)
        let presenter = DetailsPresenter()
        let router = DetailsRouter(sceneFactory: sceneFactory)
        
        presenter.vc = vc
        router.source = vc
        
        interactor.presenter = presenter
        
        vc.interactor = interactor
        vc.router = router
        
        return vc as! T
    }
}
