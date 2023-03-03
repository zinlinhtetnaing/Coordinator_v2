//
//  CashInConfirmCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

class CashInConfirmCoordinator: BaseRouter, Coordinator {
    
    weak var parentCoordinator: CashInCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        debugPrint("CashIn Confirm Coordinator Start")
        let vc = CashInConfirmViewController.instatiate(storyboard: .cashinConfirm)
        vc.coordinator = self
        transition(.push(scene: vc, animated: true))
//        navigationController.pushViewController(vc, animated: true)
    }
    
}

extension CashInConfirmCoordinator {
    
    func navigateToCashInSuccess() {
        let child = CashInSuccessCoordinator(navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        debugPrint("CashIn Confirm child count", childCoordinators.count)
        child.start()
    }
    
    func backToCashIn() {
        transition(.pop(animated: true))
    }
    
}

