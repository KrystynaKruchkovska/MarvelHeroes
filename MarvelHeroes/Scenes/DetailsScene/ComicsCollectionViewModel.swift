//
//  ComicsCollectionViewModel.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 26/10/2022.
//  
//


import UIKit

class ComicsCollectionViewModel: CollectionViewModel<ComicsCollectionViewCell> {
    
}

extension ComicsCollectionViewModel: UICollectionViewDelegate {
    
    private var vc: DetailsViewController? {
        return parentVC as? DetailsViewController
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
