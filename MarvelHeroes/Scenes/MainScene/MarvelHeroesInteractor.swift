//
//  MarvelHeroesInteractor.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import Foundation
import Combine
import os.log
import UIKit

class MarvelHeroesInteractor {
    
    var presenter: MarvelHeroesPresenter?
    var heroesListWorker: HeroesListWorker?
    var imageServiceWorker: ImageServiceWorker?
    
    private var disposalBag = Set<AnyCancellable>()
    
    func getHeroes() {
        heroesListWorker?.fetchHeroes()
            .sink(receiveCompletion: { status in
                if case let .failure(error) = status {
                    self.presenter?.showFetchedHeroesFailure(message: error.localizedDescription)
                }
                
            }, receiveValue: { [weak self] heroesResponse in
                
                let results = heroesResponse.data.results
                if results.count < 1 {
                    self?.presenter?.showFetchedHeroesFailure(message: CustomError.noDataToShow.description)
                } else {
                    self?.presenter?.showFetchedHeroes(results: heroesResponse.data.results)
                }
            })
            .store(in: &disposalBag)
    }
    
}

enum CustomError: String, Error {
    case noDataToShow
    
    public var description: String {
        switch self {
        case .noDataToShow:
            return "No data to show"
        }
    }
}
