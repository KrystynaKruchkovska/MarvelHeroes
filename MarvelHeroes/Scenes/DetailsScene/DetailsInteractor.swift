//
//  DetailsInteractor.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import Foundation
import Combine

final class DetailsInteractor {
    
    var presenter: DetailsPresenter?
    var imageWorker: ImageServiceProtocol?
    var heroDetailsWorker: HeroDetailsWorkerProtocol?
    
    private var hero: DefaultHeroesService.Response.Character
    private var disposalBag = Set<AnyCancellable>()
    
    
    init(hero: DefaultHeroesService.Response.Character) {
        self.hero = hero
    }
    
    func fetchHerosDatails() {
        if let imageUrl = hero.getImageUrl() {
            imageWorker?.downloadImage(for: imageUrl)
                .receive(on: DispatchQueue.main)
                .sink { image in
                    self.presenter?.show(self.hero, heroImage: image)
                }.store(in: &disposalBag)
        }
    }
    
    func getComics(items: [DefaultHeroesService.Response.ComicsItem]) {
//        var result = [DefaultHeroesService.Response.Comics]()
        //        items.forEach { item in
        //            if let path = item.resourceURI.components(separatedBy: "/").last {
        //                let endpoint  = MarvelHeroesEndpoint.getComics(lastPathComponent: path)
        //                heroDetailsWorker?.fetchComics(endpoint: endpoint)
        //                    .sink(receiveCompletion: { status in
        //
        //                    }, receiveValue: { comics in
        //                        if let comics = comics.data.results.first {
        //                            result.append(comics)
        //                        }
        //                        print("HERE: \(result.count)")
        //                    }).store(in: &disposalBag)
        //            }
        //
        //        }
        
       let myresult =  items.compactMap { item in
            if let path = item.resourceURI.components(separatedBy: "/").last {
                let endpoint  = MarvelHeroesEndpoint.getComics(lastPathComponent: path)
                return heroDetailsWorker?.fetchComics(endpoint: endpoint)
                    .eraseToAnyPublisher()
                
            } else {
                return nil
            }
       }
        

        presenter?.show(comicsData: myresult)
//        var a =  Publishers.MergeMany(myresult)
//            .collect() // wait for MergeMany to complete
//            .eraseToAnyPublisher()
        
    }
}


struct ZipMany<Element, Failure>: Publisher where Failure: Error {
    typealias Output = [Element]

    private let underlying: AnyPublisher<Output, Failure>

    init<T: Publisher>(publishers: [T]) where T.Output == Element, T.Failure == Failure {
        let zipped: AnyPublisher<[T.Output], T.Failure>? = publishers.reduce(nil) { result, publisher in
            if let result = result {
                return publisher.zip(result).map { element, array in
                    array + [element]
                }.eraseToAnyPublisher()
            } else {
                return publisher.map { [$0] }.eraseToAnyPublisher()
            }
        }
        underlying = zipped!.eraseToAnyPublisher()
    }

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        underlying.receive(subscriber: subscriber)
    }
}
