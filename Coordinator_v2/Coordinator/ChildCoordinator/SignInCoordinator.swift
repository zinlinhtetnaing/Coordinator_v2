//
//  SignInCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import Foundation
import UIKit

class SignInCoordinator: BaseRouter, Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        debugPrint("SignIn Coordinator Start")
        let vc = SignInViewController.instatiate(storyboard: .signIn)
//        let nav = BaseNavigationController(rootViewController: vc)
        vc.coordinator = self
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        /// vc.modalPresentationStyle = .fullScreen
        /// navigationController.present(vc, animated: true)
        transition(.modal(scene: vc, animated: true))
    }
    
}

extension SignInCoordinator {

    func navigateToDashboard() {
        navigationController.dismiss(animated: true) {
            let base = BaseTabBarController()
            base.modalPresentationStyle = .fullScreen
            self.transition(.modal(scene: base, animated: true))
        }
    }
    
    func dismiss() {
        transition(.dismiss(animated: true))
    }
    
}
