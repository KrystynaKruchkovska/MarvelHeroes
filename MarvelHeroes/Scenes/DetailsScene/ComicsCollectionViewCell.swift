//
//  ComicsCollectionViewCell.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 26/10/2022.
//  
//


import UIKit

final class ComicsCollectionViewCell: MarvelDefaultCell, Providable {

    typealias ProvidedItem = DefaultHeroesService.Response.Comics
    
    func provide(_ item: ProvidedItem) {
        update(with: item.thumbnail.getImageUrl(), title: item.title)
    }
}
