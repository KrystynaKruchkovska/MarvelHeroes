//
//  MarvelHeroesInteractor.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
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
            .sink(receiveCompletion: {
                status in
                if case let .failure(error) = status {
                    self.presenter?.showFetchedHeroesFailure(message: error.localizedDescription)
                }
                print("STATTUS: \(status)")
            }, receiveValue: { [weak self] response in
                self?.presenter?.showFetchedHeroes(results: response.data.results)
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
