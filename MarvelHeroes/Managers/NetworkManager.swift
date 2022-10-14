//
//  NetworkManager.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import Foundation
import Combine

protocol NetworkManager {
    var session: NetworkSession { get }
    func publisher<T: Decodable>(for request: URLRequest) -> AnyPublisher<T, Error>
}

private extension NetworkManager {
    var decoder : JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func makePublisher<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        
        session.publisher(for: request)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}


struct DefaultNetworkManager: NetworkManager {
    private (set) var session: NetworkSession
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func publisher<T>(for request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        makePublisher(request: request)
    }
}
