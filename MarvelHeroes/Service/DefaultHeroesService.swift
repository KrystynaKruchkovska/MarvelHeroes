//
//  DefaultHeroesService.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import Foundation
import Combine

struct DefaultHeroesService {
    
    struct Response: Decodable {
        let data: ResponseData
        
        struct ResponseData: Decodable {
            let results: [Result]
        }
        
        struct Result: Decodable {
            let id: Int
            let name, description: String
            let modified: Date
            let thumbnail: Thumbnail
            let resourceURI: String
            let comics, series: Comics
        }
        
        struct Thumbnail: Codable {
            let path: String
            let thumbnailExtension: Extension
            
            enum CodingKeys: String, CodingKey {
                case path
                case thumbnailExtension = "extension"
            }
            
            enum Extension: String, Codable {
                case jpg = "jpg"
                case gif = "gif"
                case other =  "png"
                
                init(from decoder: Decoder) throws {
                    let label = try decoder.singleValueContainer().decode(String.self)
                    self = Extension(rawValue: label) ?? Extension.other
                }
            }
        }
        
        struct Comics: Codable {
            let available: Int
            let collectionURI: String
            let items: [ComicsItem]
            let returned: Int
        }
        
        struct ComicsItem: Codable {
            let resourceURI: String
            let name: String
        }
    }
    
    private let networkManager: NetworkManager
    private let endpoint: Endpoint
    
    init(networkManager: NetworkManager, endpoint: Endpoint) {
        self.networkManager = networkManager
        self.endpoint = endpoint
    }
    
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
    
    func download() -> AnyPublisher<Response, Error> {
        networkManager.publisher(for: request)
    }
}

extension DefaultHeroesService.Response.Result: Hashable {
    
    func hash(into hasher: inout Hasher) {
      // 2
        hasher.combine(id)
    }
    
    static func == (lhs: DefaultHeroesService.Response.Result, rhs: DefaultHeroesService.Response.Result) -> Bool {
        lhs.id == rhs.id
    }
}
