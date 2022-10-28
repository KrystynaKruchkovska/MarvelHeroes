//
//  DefaultCellLayout.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 28/10/2022.
//  
//


import UIKit

enum DefaultCellLayout {
    static var cornerRadius: CGFloat = 5
    static let characterImageHeight: CGFloat = 200
    static let characterImageWidth: CGFloat = 120
    static let collectionViewItemSize:CGSize = CGSize(width: characterImageWidth, height: characterImageHeight)
    static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}
