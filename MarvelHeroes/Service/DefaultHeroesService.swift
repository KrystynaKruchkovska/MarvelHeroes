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
            let results: [Character]
        }
        
        struct Character: Decodable {
            let id: Int
            let name, description: String
            let modified: Date?
            let thumbnail: Thumbnail
            let resourceURI: String
            let comics, series: ComicsCollection
            
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
                let container: KeyedDecodingContainer<DefaultHeroesService.Response.Character.CodingKeys> = try decoder.container(keyedBy: DefaultHeroesService.Response.Character.CodingKeys.self)
                self.id = try container.decode(Int.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.id)
                self.name = try container.decode(String.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.name)
                self.description = try container.decode(String.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.description)
                
                if let dateStr = try container.decodeIfPresent(String.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.modified) {
                    self.modified = dateStr.yyyyMMddFormatDate
                } else {
                    self.modified  = nil
                }
   
                self.thumbnail = try container.decode(DefaultHeroesService.Response.Thumbnail.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.thumbnail)
                self.resourceURI = try container.decode(String.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.resourceURI)
                self.comics = try container.decode(DefaultHeroesService.Response.ComicsCollection.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.comics)
                self.series = try container.decode(DefaultHeroesService.Response.ComicsCollection.self, forKey: DefaultHeroesService.Response.Character.CodingKeys.series)
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
            
            func getImageUrl() -> URL? {
                let imgUrl = self.path + "." +
                self.thumbnailExtension.rawValue
                guard var comps = URLComponents(string: imgUrl) else {
                    return nil
                }
                comps.scheme = "https"
                guard let url = comps.url else {
                    return nil
                }
                return url
            }

        }
        
        struct ComicsCollection: Codable {
            let available: Int
            let collectionURI: String
            let items: [ComicsItem]
            let returned: Int
        }
        
        struct ComicsItem: Codable {
            let resourceURI: String
            let name: String
        }
        
        struct ComicsData: Codable {
            let data: ComicsResults
           
        }
        
        struct ComicsResults: Codable {
            let results: [Comics]
        }
        // MARK: - Result
        struct Comics: Codable {
//            let id: Int
            let title: String
//            let issueNumber: Int
//            let variantDescription, resultDescription: String
//            let modified: Date
//            let isbn, upc, diamondCode, ean: String
//            let issn, format: String
//            let pageCount: Int
//            let textObjects: [TextObject]
//            let resourceURI: String
//            let urls: [URLElement]
//            let series: Series
//            let variants, collections, collectedIssues: [JSONAny]
//            let dates: [DateElement]
//            let prices: [Price]
            let thumbnail: Thumbnail
            let images: [Thumbnail]
//            let creators: Creators
//            let characters: Characters
//            let stories: Stories
//            let events: Characters
            
            enum CodingKeys: String, CodingKey {
                case title, thumbnail, images
                
                
            }
            init(from decoder: Decoder) throws {
                let container: KeyedDecodingContainer<DefaultHeroesService.Response.Comics.CodingKeys> = try decoder.container(keyedBy: DefaultHeroesService.Response.Comics.CodingKeys.self)
//                self.id = try container.decode(Int.self, forKey: DefaultHeroesService.Response.Comics.CodingKeys.id)
                self.title = try container.decode(String.self, forKey: DefaultHeroesService.Response.Comics.CodingKeys.title)
//                self.variantDescription = try container.decode(String.self, forKey: DefaultHeroesService.Response.Comics.CodingKeys.variantDescription)
//                self.resultDescription = try container.decode(String.self, forKey: DefaultHeroesService.Response.Comics.CodingKeys.resultDescription)
                self.thumbnail = try container.decode(DefaultHeroesService.Response.Thumbnail.self, forKey: DefaultHeroesService.Response.Comics.CodingKeys.thumbnail)
                self.images = try container.decode([DefaultHeroesService.Response.Thumbnail].self, forKey: DefaultHeroesService.Response.Comics.CodingKeys.images)
            }
        }
    }
    
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func download<T: Decodable>(for request: URLRequest) -> AnyPublisher<T, Error> {
        networkManager.publisher(for: request)
    }
}

extension DefaultHeroesService.Response.Character: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DefaultHeroesService.Response.Character, rhs: DefaultHeroesService.Response.Character) -> Bool {
        lhs.id == rhs.id
    }
}

extension DefaultHeroesService.Response.Comics: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: DefaultHeroesService.Response.Comics, rhs: DefaultHeroesService.Response.Comics) -> Bool {
        lhs.title == rhs.title
    }
}
