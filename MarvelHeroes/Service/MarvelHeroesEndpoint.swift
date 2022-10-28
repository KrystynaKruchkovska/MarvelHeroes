//
//  MarvelHeroesEndpoint.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: String { get }
}

enum MarvelHeroesEndpoint: Endpoint {
    case getSearchResult(offset: Int, limit: Int)
    case getComics(lastPathComponent: String)
        
    var scheme: String {
        return "https"
    }
    
    var baseUrl: String {
        return  "gateway.marvel.com"
    }
    
    var path: String {

        if case let .getComics(resourceURI) = self {
            return "/v1/public/comics/\(resourceURI)"
        }
        return "/v1/public/characters"
    }
    
    var parameters: [URLQueryItem]? {

        if case let .getSearchResult(offset, limit) = self {
            return  [
                 URLQueryItem(name: "ts", value: "1665583817.3794498"),
                 URLQueryItem(name: "apikey", value: "505ea7d44709a9e85ef32c69a56cb2c7"),
                 URLQueryItem(name: "hash", value: "5f109791c9236a331fd0f1ad9aa889e8"),
                 URLQueryItem(name: "limit", value: String(limit)),
                 URLQueryItem(name: "offset", value: String(offset))
             ]
        }
        if case .getComics(_) = self {
            return [
                URLQueryItem(name: "ts", value: "1665583817.3794498"),
                URLQueryItem(name: "apikey", value: "505ea7d44709a9e85ef32c69a56cb2c7"),
                URLQueryItem(name: "hash", value: "5f109791c9236a331fd0f1ad9aa889e8")
            ]
        }
       return  nil
    }
    
    var method: String {
        return "GET"
    }
}
