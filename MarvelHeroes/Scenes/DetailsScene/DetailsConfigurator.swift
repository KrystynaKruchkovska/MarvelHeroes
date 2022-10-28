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
    private var hero: DefaultHeroesService.Response.Character
    
    init(sceneFactory: SceneFactory,
         hero: DefaultHeroesService.Response.Character) {
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
        
        let networkSession = DefaultNetworkSession()
        let networManager = DefaultNetworkManager(session: networkSession)
        let service = DefaultHeroesService(networkManager: networManager)

        interactor.presenter = presenter
        interactor.heroDetailsWorker = HeroDetailsWorker(service: service)
        interactor.imageWorker = dependencyProvider.imageServiceWorker
        
        
        vc.interactor = interactor
        vc.router = router
        
        return vc as! T
    }
}
