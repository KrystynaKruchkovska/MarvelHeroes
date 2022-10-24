//
//  ImageDownloader.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 14/10/2022.
//

import UIKit
import Combine

protocol ImageServiceProtocol {
    var imageCacheWorker: ImageCache? { get set }
    var downloadImageWorker: DownloadImageWorker? { get set }
    func downloadImage(for url: URL) -> Future<UIImage, Never>
}

class ImageServiceWorker: ImageServiceProtocol {
    var imageCacheWorker: ImageCache?
    var downloadImageWorker: DownloadImageWorker?
    private var disposalBag = Set<AnyCancellable>()
    
    func downloadImage(for url: URL) -> Future<UIImage, Never> {
        Future { promise in
            if let imageCache = self.imageCacheWorker?.getImage(for: url) {
                promise(.success(imageCache))
            } else {
                self.downloadImageWorker?.load(url: url).sink(receiveCompletion: { status in
                    
                }, receiveValue: { image in
                    self.imageCacheWorker?.setImage(image, for: url)
                    promise(.success(image))
                })
                .store(in: &self.disposalBag)
            }
        }
    }
    
    deinit {
        print("Deinit")
    }
}
