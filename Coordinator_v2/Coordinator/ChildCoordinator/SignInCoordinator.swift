//
//  SignInCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import Foundation
import UIKit
import resource_spm

class SignInCoordinator: BaseRouter, Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init(rootController: navigationController)
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


extension UIView {
    func setGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [(UIColor(red: 255/255, green: 171/255, blue: 171/255, alpha: 0).cgColor), (UIColor(red: 255/255, green: 171/255, blue: 171/255, alpha: 1.00).cgColor)].map { $0 }
        gradient.startPoint = CGPoint(x : 1.0, y : 1.0)
        gradient.endPoint = CGPoint(x :1.0, y: 0.0)
        gradient.locations = [0.1, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
