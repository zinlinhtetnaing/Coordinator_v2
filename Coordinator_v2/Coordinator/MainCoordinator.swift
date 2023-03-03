//
//  MainCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

class MainCoordinator: BaseRouter, Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        let vc = ViewController.instatiate(storyboard: .main)
        vc.coordinator = self
//        transition(.modal(scene: vc, animated: false))
//        transition(.push(scene: vc, animated: false))
        self.navigationController.viewControllers = [vc]
        /// navigationController.pushViewController(vc, animated: true)
    }
    
}

extension MainCoordinator {
    
    func signIn() {
        let child = SignInCoordinator(navigationController)
        child.parentCoordinator = self
        childCoordinators.removeAll()
        childCoordinators.append(child)
        debugPrint("SignIn child count", childCoordinators.count)
        child.start()
    }
    
}
