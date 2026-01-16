//
//  Coordinator.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: BaseNavigationController { get set }
    func start()
}

extension Coordinator {
    
    // Remove Child Coordinator
    func childDidFinish() {
        debugPrint("Coordinators: ----", childCoordinators.count, childCoordinators)
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === self {  /// self is child coordinator
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.navigationController.present(alert, animated: true)
        })
    }
    
}
