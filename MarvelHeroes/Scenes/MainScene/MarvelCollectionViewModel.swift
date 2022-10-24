//
//  MarvelCollectionViewModel.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 13/10/2022.
//

import UIKit

class MarvelColllectionViewModel: CollectionViewModel<HeroCollectionViewCell> {
    
}

extension MarvelColllectionViewModel: UICollectionViewDelegate {
    
    private var vc: MarvelHeroesViewController? {
        return parentVC as? MarvelHeroesViewController
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == items.value.count - 80) {
            vc?.interactor?.getHeroes()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let hero = self.items.value[indexPath.row]
        vc?.router?.showDetailsVC(with: hero)
    }
}
