//
//  MarvelHeroesEndpoint.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
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
    case getSearchResult(numberOfItems: Int)
        
    var scheme: String {
        return "https"
    }
    
    var baseUrl: String {
        return  "gateway.marvel.com"
    }
    
    var path: String {
        return "/v1/public/characters"
    }
    
    var parameters: [URLQueryItem]? {

       return  [
            URLQueryItem(name: "ts", value: "1665583817.3794498"),
            URLQueryItem(name: "apikey", value: "505ea7d44709a9e85ef32c69a56cb2c7"),
            URLQueryItem(name: "hash", value: "5f109791c9236a331fd0f1ad9aa889e8"),
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "offset", value: "0"),
        ]
    }
    
    var method: String {
        return "GET"
    }
}
