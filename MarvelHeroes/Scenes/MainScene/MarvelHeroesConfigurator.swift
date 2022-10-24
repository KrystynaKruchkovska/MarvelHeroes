//
//  MarvelHeroesConfigurator.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import UIKit

final class MarvelHeroesConfigurator: SceneConfigurator {
    
    private weak var sceneFactory: SceneFactory?
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    func configured<T: UIViewController>(_ vc: T) -> T {
        guard let vc = vc as? MarvelHeroesViewController else {
            fatalError()
        }
        
        let networkSession = DefaultNetworkSession()
        let networManager = DefaultNetworkManager(session: networkSession)
        let service = DefaultHeroesService(networkManager: networManager)
        
        let interactor = MarvelHeroesInteractor()
        let presenter = MarvelHeroesPresenter()
        let router = MarvelHeroesRouter(sceneFactory: sceneFactory)
        router.source = vc
        
        presenter.vc = vc
    
        interactor.presenter = presenter
        interactor.heroesListWorker = HeroesListWorker(service: service)
        interactor.imageServiceWorker = dependencyProvider.imageServiceWorker
        
        vc.interactor = interactor
        vc.router = router
        
        return vc as! T
    }
    
}
