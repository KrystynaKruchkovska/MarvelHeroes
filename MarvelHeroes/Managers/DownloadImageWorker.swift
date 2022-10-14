//
//  DownloadImageWorker.swift
//  MarvelHeroes
//
//  Created by Paweł on 14/10/2022.
//

import UIKit
import Combine

protocol DownloadImageProtocol {
    func load(url: URL) -> Future<UIImage, Error>
}

class DownloadImageWorker: DownloadImageProtocol {
    private var disposalBag = Set<AnyCancellable>()
    
    func load(url: URL) -> Future<UIImage, Error> {
        Future { promise in
            URLSession.shared
                .dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceNil(with: UIImage())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { status in
                    print("STATUS \(url)")
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
