//
//  NavigationBar+Extension.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 14/10/2022.
//

import UIKit

extension UINavigationBar {

    func setAppStyle() {
        barStyle = .black
        tintColor = UIColor.white
        titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
