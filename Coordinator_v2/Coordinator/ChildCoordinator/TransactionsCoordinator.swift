//
//  TransactionsCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import Foundation
import UIKit

class TransactionsCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        debugPrint("Dashboard Coordinator Start")
        let vc = TransactionsViewController()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(vc, animated: true)
    }
    
}

extension TransactionsCoordinator {

}
