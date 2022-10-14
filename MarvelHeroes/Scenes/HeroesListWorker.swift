//
//  HeroesListWorker.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import Foundation
import Combine
import os.log

final class HeroesListWorker {
    
    private let service: DefaultHeroesService
    private var disposalBag = Set<AnyCancellable>()
    private lazy var logger = Logger(subsystem: String(describing: self), category: "Worker")
    
    init(service: DefaultHeroesService) {
        self.service = service
    }
}

extension HeroesListWorker {
    func fetchHeroes() -> Future<DefaultHeroesService.Response, Error> {
        Future { [weak self] promise in
            self?.service.download()
                .sink { [weak self] status in
                    if case let .failure(error) = status {
                        promise(.failure(error))
                    }
                    self?.logger.info("Status recived: \(String(describing: status))")
                } receiveValue: { heroes in
                    promise(.success(heroes))
                }.store(in: &self!.disposalBag)
        }
    }
}
