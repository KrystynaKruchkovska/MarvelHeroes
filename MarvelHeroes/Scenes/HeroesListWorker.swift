//
//  HeroesListWorker.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import Foundation
import Combine
import os.log

final class HeroesListWorker {
    
    private let service: DefaultHeroesService
    private var disposalBag = Set<AnyCancellable>()
    private lazy var logger = Logger(subsystem: String(describing: self), category: String(describing: self))
    private var endpoint: Endpoint
    private var offset = 0

    private var request: URLRequest {
        var componetns = URLComponents()
        componetns.scheme = endpoint.scheme
        componetns.host = endpoint.baseUrl
        componetns.path = endpoint.path
        componetns.queryItems = endpoint.parameters
        
        guard let url = componetns.url else {
            fatalError("BAD URL\(componetns)")
        }
        return URLRequest(url: url)
    }
    
    init(service: DefaultHeroesService, endpoint: Endpoint = MarvelHeroesEndpoint.getSearchResult(offset: 0, limit: 100)) {
        self.service = service
        self.endpoint = endpoint
    }
}

extension HeroesListWorker {
    func fetchHeroes() -> Future<DefaultHeroesService.Response, Error> {
        Future { [weak self] promise in
            guard let self = self else {
                return
            }
            self.service.download(for: self.request)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] status in
                    if case let .failure(error) = status {
                        promise(.failure(error))
                    }
                    self?.logger.info("Status recived: \(String(describing: status))")
                } receiveValue: { heroes in
                    promise(.success(heroes))
                    self.offset += heroes.data.results.count
                    self.endpoint = MarvelHeroesEndpoint.getSearchResult(offset: self.offset, limit: 100)
                }.store(in: &self.disposalBag)
        }
    }
}
