//
//  MarvelHeroesViewController.swift
//  MarvelHeroes
//
//  Created by Paweł on 12/10/2022.
//

import UIKit

class MarvelHeroesViewController: UIViewController {

    var interactor: MarvelHeroesInteractor?
    var router: MarvelHeroesRouter?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.getHeroes()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
