//
//  CashInSuccessCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

class CashInSuccessCoordinator: Coordinator {
    
    weak var parentCoordinator: CashInConfirmCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        debugPrint("CashIn Success Coordinator Start")
        let vc = CashInSuccessViewController.instatiate(storyboard: .cashInSuccess)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}


extension CashInSuccessCoordinator {
    
    func popToRootView() {
        navigationController.popToRootViewController(animated: true)
    }
  
}

