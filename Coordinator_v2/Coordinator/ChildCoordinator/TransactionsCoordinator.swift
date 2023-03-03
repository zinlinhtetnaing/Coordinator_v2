//
//  TransactionsCoordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import Foundation
import UIKit

class TransactionsCoordinator: BaseRouter, Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: BaseNavigationController
    
    init(_ navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        debugPrint("Transaction Coordinator Start")
        let vc = TransactionsViewController()
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
//        transition(.push(scene: vc, animated: true))
        navigationController.pushViewController(vc, animated: true)
    }
    
}

extension TransactionsCoordinator {

}
