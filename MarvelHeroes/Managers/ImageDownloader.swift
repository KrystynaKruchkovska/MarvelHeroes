//
//  ImageDownloader.swift
//  MarvelHeroes
//
//  Created by Paweł on 14/10/2022.
//

import UIKit
import Combine

class ImageDownloaderManager {
    var imageCacheWorker: ImageCache?
    var downloadImageWorker: DownloadImageWorker?
    private var disposalBag = Set<AnyCancellable>()
    
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
