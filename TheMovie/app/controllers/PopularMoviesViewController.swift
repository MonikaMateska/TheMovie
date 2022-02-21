//
//  ViewController.swift
//  TheMovie
//
//  Created by Monika Mateska on 20.2.22.
//

import UIKit

class PopularMoviesViewController: UIViewController, Storyboarded {
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func movieDetailsTapped(_ sender: Any) {
        coordinator?.movieDetails()
    }
    


}

