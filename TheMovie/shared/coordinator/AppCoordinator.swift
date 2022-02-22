//
//  AppCoordinator.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private var localStorage: LocalStorage = UserDefaultsStorage()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = PopularMoviesViewController.instantiate()
        vc.coordinator = self
        vc.localStorage = localStorage
        navigationController.pushViewController(vc, animated: false)
    }
    
    func movieDetails(of movie: PopularMovieModel) {
        let vc = MovieDetailsViewController.instantiate()
        vc.fetchDetails(of: movie)
        vc.coordinator = self
        vc.localStorage = localStorage
        navigationController.pushViewController(vc, animated: true)
    }
}
