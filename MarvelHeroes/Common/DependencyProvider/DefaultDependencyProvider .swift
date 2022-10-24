//
//  DefaultDependencyProvider .swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import Foundation

protocol DependencyProvider: AnyObject {

    var imageServiceWorker: ImageServiceWorker { get }
}

final class DefaultDependencyProvider: DependencyProvider {

    let imageServiceWorker: ImageServiceWorker

    init() {
        let imageServiceWorker = ImageServiceWorker()
        imageServiceWorker.downloadImageWorker = DownloadImageWorker()
        imageServiceWorker.imageCacheWorker = ImageCacheWorker()
        
        self.imageServiceWorker = imageServiceWorker
    }
}
