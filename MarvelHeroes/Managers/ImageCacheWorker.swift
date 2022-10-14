//
//  ImageCacheWorker.swift
//  MarvelHeroes
//
//  Created by Paweł on 14/10/2022.
//

import UIKit

protocol ImageCache {
    func setImage(_ image: UIImage, for URL: URL)
    func getImage(for URL: URL) -> UIImage?
}

final class ImageCacheWorker: ImageCache {

    private let cache = NSCache<NSURL, UIImage>()

    func setImage(_ image: UIImage, for URL: URL) {
        cache.setObject(image, forKey: URL as NSURL)
    }

    func getImage(for URL: URL) -> UIImage? {
        cache.object(forKey: URL as NSURL)
    }
}
