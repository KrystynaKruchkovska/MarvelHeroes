//
//  DownloadImageWorker.swift
//  MarvelHeroes
//
//  Created by Paweł on 14/10/2022.
//

import UIKit
import Combine

class DownloadImageWorker {
    private var disposalBag = Set<AnyCancellable>()
    
    func load(url: URL) -> Future<UIImage, Error> {
        Future { promise in
            URLSession.shared
                .dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceNil(with: UIImage())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { status in
                    if case let .failure(error) = status {
                        promise(.failure(error))
                    }
                }, receiveValue: { image in
                    promise(.success(image))
                })
                .store(in: &self.disposalBag)
        }
    }
}
