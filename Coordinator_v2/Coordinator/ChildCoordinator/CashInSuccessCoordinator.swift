//
//  CashInSuccessCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

class CashInSuccessCoordinator: BaseRouter, Coordinator {
    
    weak var parentCoordinator: CashInConfirmCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        debugPrint("CashIn Success Coordinator Start")
        let vc = CashInSuccessViewController.instatiate(storyboard: .cashInSuccess)
        vc.coordinator = self
        transition(.push(scene: vc, animated: true))
        /// navigationController.pushViewController(vc, animated: true)
    }
    
}


extension CashInSuccessCoordinator {
    
    func popToCashInView() {
        for vc in navigationController.viewControllers {
            if let cashInVc = vc as? CashInViewController {
                cashInVc.coordinator?.childCoordinators.removeAll()
                transition(.popTo(scene: cashInVc, animated: true))
            }
        }
    }
    
    func popToRootView() {
        transition(.popToRoot(animated: true))
    }
  
}

