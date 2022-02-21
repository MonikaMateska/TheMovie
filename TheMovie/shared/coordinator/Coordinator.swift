//
//  Coordinator.swift
//  TheMovie
//
//  Created by Monika Mateska on 21.2.22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
