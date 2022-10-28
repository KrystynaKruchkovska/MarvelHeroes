//
//  HeroCollectionViewCell.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 13/10/2022.
//

import UIKit
import Combine

final class HeroCollectionViewCell: MarvelDefaultCell, Providable {
    
    typealias ProvidedItem = DefaultHeroesService.Response.Character

    func provide(_ item: ProvidedItem) {
        update(with: item.thumbnail.getImageUrl(), title: item.name)
    }
}


