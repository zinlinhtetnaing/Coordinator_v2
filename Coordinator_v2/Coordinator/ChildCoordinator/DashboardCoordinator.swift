//
//  DashboardCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

class DashboardCoordinator: NSObject, Coordinator {
    
    weak var parentCoordinator: SignInCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DashboardViewController.instatiate(storyboard: .dashboard)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
        /*
         vc.navigationController?.navigationItem.hidesBackButton = true
         navigationController.dismiss(animated: true) {
         self.navigationController.setViewControllers([vc], animated: true)
         self.navigationController.pushViewController(vc, animated: true)
         }
         */
    }
    
}

extension DashboardCoordinator {
   
    func navigateToCashIn() {
        let child = CashInCoordinator(navigationController)
        child.parentCoordinator = self
        childCoordinators.removeAll()
        childCoordinators.append(child)
        debugPrint("Dashboard child count", childCoordinators.count)
        child.start()
    }
    
}
