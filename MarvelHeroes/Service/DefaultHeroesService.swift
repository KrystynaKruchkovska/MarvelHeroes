//
//  DefaultHeroesService.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 12/10/2022.
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
            let modified: Date?
            let thumbnail: Thumbnail
            let resourceURI: String
            let comics, series: Comics
            
            enum CodingKeys: CodingKey {
                case id
                case name
                case description
                case modified
                case thumbnail
                case resourceURI
                case comics
                case series
            }
            
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<DefaultHeroesService.Response.Result.CodingKeys> = try decoder.container(keyedBy: DefaultHeroesService.Response.Result.CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.id)
                self.name = try container.decode(String.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.name)
                self.description = try container.decode(String.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.description)
                
                if let dateStr = try container.decodeIfPresent(String.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.modified) {
                    self.modified = dateStr.yyyyMMddFormatDate
                } else {
                    self.modified  = nil
                }
   
                self.thumbnail = try container.decode(DefaultHeroesService.Response.Thumbnail.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.thumbnail)
                self.resourceURI = try container.decode(String.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.resourceURI)
                self.comics = try container.decode(DefaultHeroesService.Response.Comics.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.comics)
                self.series = try container.decode(DefaultHeroesService.Response.Comics.self, forKey: DefaultHeroesService.Response.Result.CodingKeys.series)
            }
        }
        
        struct Thumbnail: Codable {
            let path: String
            let thumbnailExtension: Extension
            
            enum CodingKeys: String, CodingKey {
                case path
                case thumbnailExtension = "extension"
            }
            
            enum Extension: String, Codable {
                case jpg   = "jpg"
                case gif   = "gif"
                case other = "png"
                
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

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func download(for request: URLRequest) -> AnyPublisher<Response, Error> {
        networkManager.publisher(for: request)
    }
}

extension DefaultHeroesService.Response.Result: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DefaultHeroesService.Response.Result, rhs: DefaultHeroesService.Response.Result) -> Bool {
        lhs.id == rhs.id
    }
}
