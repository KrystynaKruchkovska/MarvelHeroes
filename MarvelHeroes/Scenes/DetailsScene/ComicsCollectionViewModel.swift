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

extension ComicsCollectionViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let orintation  = UIDevice.current.orientation

        if case .portrait = orintation {
            return CGSize(width: DefaultCellLayout.characterImageWidth, height: DefaultCellLayout.characterImageHeight)
            
        } else {
            return CGSize(width: DefaultCellLayout.characterImageWidth, height: floor(collectionView.frame.height) - 20)
        }
    }
}
