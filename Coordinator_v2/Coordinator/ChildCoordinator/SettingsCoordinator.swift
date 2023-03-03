//
//  SettingsCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import Foundation
import UIKit

class SettingsCoordinator: BaseRouter, Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        debugPrint("Settings Coordinator Start")
        let vc = SettingsViewController()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
//        transition(.push(scene: vc, animated: true))
        navigationController.pushViewController(vc, animated: true)
    }
    
}

extension SettingsCoordinator {
    
    func logout() {
        let child = SignInCoordinator(self.navigationController)
        child.childDidFinish()
        childCoordinators.append(child)
        child.start()
    }
    
    func alertBox() {
//        self.showAlert(withTitle: "Logout", withMessage: "You want to logut?")
        
    }
}
