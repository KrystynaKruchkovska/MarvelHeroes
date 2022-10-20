//
//  Alert.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 13/10/2022.
//

import UIKit

protocol InfoAlert {
    func show(
        on viewController: UIViewController,
        title: String,
        message: String?,
        buttonTitle: String,
        acceptanceCompletion: (() -> Void)?)
}

extension InfoAlert {
    func show(
        on viewController: UIViewController,
        title: String = "Opps",
        message: String?,
        buttonTitle: String = "Ok",
        acceptanceCompletion: (() -> Void)?) {
            show(on: viewController, title: title, message: message, buttonTitle: "Ok", acceptanceCompletion: acceptanceCompletion)
        }
}


final class DefaultInfoAlert: InfoAlert {
    func show(
        on viewController: UIViewController,
        title: String = "Opps",
        message: String?,
        buttonTitle: String = "Ok",
        acceptanceCompletion: (() -> Void)?) {
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            acceptanceCompletion?()
        })
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
