//
//  NetworkSession.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import Foundation
import Combine

protocol NetworkSession {
    func publisher(for request: URLRequest) -> AnyPublisher<Data, Error>
    
}

class DefaultNetworkSession: NetworkSession {
    func publisher(for request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .retry(2)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            }.eraseToAnyPublisher()
    }
}

enum NetworkError: String, Error {
    case invalidURL
    case responseError
    case unknown
}

