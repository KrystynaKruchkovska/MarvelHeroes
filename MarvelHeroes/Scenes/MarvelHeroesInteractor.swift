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
    var imageCacheWorker: ImageCache?
    var downloadImageWorker: DownloadImageWorker?
    
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
    
    func downloadImage(for url: URL) -> Future<UIImage, Never> {
        Future { promise in
            if let imageCache = self.imageCacheWorker?.getImage(for: url) {
                promise(.success(imageCache))
            } else {
                self.downloadImageWorker?.load(url: url).sink(receiveCompletion: { status in
                    
                }, receiveValue: { [weak self] image in
                    self?.imageCacheWorker?.setImage(image, for: url)
                    promise(.success(image))
                })
                .store(in: &self.disposalBag)
            }
        }
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
