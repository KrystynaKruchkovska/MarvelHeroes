//
//  ProvidableProtocol.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 28/10/2022.
//  
//


import Foundation

protocol Providable {
    associatedtype ProvidedItem: Hashable
    func provide(_ item: ProvidedItem)
}
