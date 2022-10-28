//
//  HeroDetailsWorker.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 27/10/2022.
//  
//


import Foundation
import Combine

protocol HeroDetailsWorkerProtocol {
    func fetchComics(endpoint: Endpoint) -> Future<DefaultHeroesService.Response.ComicsData, Error>
}

class HeroDetailsWorker: HeroDetailsWorkerProtocol {
    var endpoint: Endpoint?
    private var disposalBag = Set<AnyCancellable>()
    private let service: DefaultHeroesService
    private var request: URLRequest {
        var componetns = URLComponents()
        componetns.scheme = endpoint!.scheme
        componetns.host = endpoint!.baseUrl
        componetns.path = endpoint!.path
        componetns.queryItems = endpoint!.parameters
        
        guard let url = componetns.url else {
            fatalError("BAD URL\(componetns)")
        }
        return URLRequest(url: url)
    }
    
    init(service: DefaultHeroesService) {
        self.service = service
    }
    
}

extension HeroDetailsWorker {
    func fetchComics(endpoint: Endpoint) -> Future<DefaultHeroesService.Response.ComicsData, Error> {
        Future { [weak self] promise in
            guard let self = self else {
                return
            }
            self.endpoint = endpoint
            self.service.download(for: self.request)
                .receive(on: DispatchQueue.main)
                .sink { status in
                    if case let .failure(error) = status {
                        print(error)
//                        promise(.failure(error))
                    }
                } receiveValue: { comics in
                    promise(.success(comics))
                    
                }.store(in: &self.disposalBag)
        }
    }
}
