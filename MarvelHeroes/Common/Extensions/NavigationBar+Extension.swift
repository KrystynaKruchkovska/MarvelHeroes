//
//  NavigationBar+Extension.swift
//  MarvelHeroes
//
//  Created by Paweł on 14/10/2022.
//

import UIKit

extension UINavigationBar {

    func setAppStyle() {
        barStyle = .black
//        barTintColor = .yellow
//        tintColor = .yellow
//        tintColor = UIColor.purple
//        barTintColor = .clear
        titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
