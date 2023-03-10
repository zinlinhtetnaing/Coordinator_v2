//
//  CashInCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

class CashInCoordinator: Coordinator {
    
    weak var parentCoordinator: DashboardCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        debugPrint("CashIn Coordinator Start")
        let vc = CashInViewController.instatiate(storyboard: .cashIn)
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
}

extension CashInCoordinator {
    
    func navigateToCashInConfirm() {
        let child = CashInConfirmCoordinator(navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        debugPrint("Cashin child count", childCoordinators.count)
        child.start()
    }
    
}
