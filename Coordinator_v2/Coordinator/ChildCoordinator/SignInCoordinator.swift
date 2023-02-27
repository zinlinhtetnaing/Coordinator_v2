//
//  SignInCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import Foundation
import UIKit

class SignInCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        debugPrint("SignIn Coordinator Start")
        let vc = SignInViewController.instatiate(storyboard: .signIn)
        let nav = BaseNavigationController(rootViewController: vc)
        vc.coordinator = self
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        navigationController.present(nav, animated: true)
    }
    
}

extension SignInCoordinator {

    func navigateToDashboard() {
        navigationController.dismiss(animated: true) {
            let base = BaseTabBarController()
            base.modalPresentationStyle = .fullScreen
            self.navigationController.present(base, animated: true)
        }
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
}
