//
//  DetailsViewController .swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 24/10/2022.
//  
//


import UIKit

protocol DetailsViewControllerOutput: AnyObject {
    func tryToFetchHerosDetailedInfo()
}

protocol DetailsViewControllerIntput: AnyObject {
    func show(_ hero: DefaultHeroesService.Response.Result, heroImage: UIImage)
}

final class DetailsViewController : UIViewController {

    var interactor: DetailsInteractor?
    var router: DetailsRouter?
    var customView: DetailsCustomView {
        self.view as! DetailsCustomView
    }
    
    override func loadView() {
        super.loadView()
        self.view = DetailsCustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryToFetchHerosDetailedInfo()
    }

}

extension DetailsViewController: DetailsViewControllerOutput {
    func tryToFetchHerosDetailedInfo() {
        interactor?.fetchHerosDatails()
    }
}

extension DetailsViewController: DetailsViewControllerIntput {
    func show(_ hero: DefaultHeroesService.Response.Result, heroImage: UIImage) {
        customView.update(with: DetailsCustomViewModel(hero: hero, heroImg: heroImage))
    }
}
