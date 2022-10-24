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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let parentVC = parentVC as? MarvelHeroesViewController  else {
            return
        }
        
        if (indexPath.row == items.value.count - 80) {
            parentVC.interactor?.getHeroes()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
