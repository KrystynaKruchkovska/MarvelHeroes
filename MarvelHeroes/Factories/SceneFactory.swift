//
//  SceneFactory.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import UIKit

protocol SceneConfigurator {
    func configured<T: UIViewController>(_ vc: T) -> T
}

protocol SceneFactory: AnyObject {
    var configurator: SceneConfigurator! { get set }
    func makeScene<T: UIViewController>() -> T
}

final class MarvelHeroesSceneFactory: SceneFactory {
    var configurator: SceneConfigurator!
    
    func makeScene<T: UIViewController>() -> T {
        let vc = MarvelHeroesViewController()
        return configurator.configured(vc) as! T
    }
}



