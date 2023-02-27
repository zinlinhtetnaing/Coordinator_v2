//
//  BaseNavigationController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 11/08/2022.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationBar.prefersLargeTitles = true
    }
    
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        switch viewController {
        case is DashboardViewController:
            viewController.title = "Home"
            viewController.view.backgroundColor = .white
        case is CashInViewController:
            viewController.title = "CashIn"
        case is CashInConfirmViewController:
            viewController.title = "CashIn Confirm"
        case is CashInSuccessViewController:
            viewController.title = "CashIn Success"
        case is SignInViewController:
            viewController.title = "Signin"
        case is QRPayViewController:
            viewController.title = "QR Pay"
            viewController.view.backgroundColor = .white
        case is TransactionsViewController:
            viewController.title = "Transactions"
            viewController.view.backgroundColor = .white
        case is SettingsViewController:
            viewController.title = "Settings"
            viewController.view.backgroundColor = .white
        default:
            viewController.title = "Landing"
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        /// Remove Child Coordinator
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let dashboardViewController = fromViewController as? DashboardViewController {
            debugPrint("\(#function)Dashboard child Coordinator counts --->", dashboardViewController.coordinator?.childCoordinators.count as Any)
            dashboardViewController.coordinator?.childDidFinish()
        }
        if let cashinViewController = fromViewController as? CashInViewController {
            debugPrint("\(#function)CashIn child Coordinator counts --->", cashinViewController.coordinator?.childCoordinators.count as Any)
            cashinViewController.coordinator?.childDidFinish()
        }
        if let cashinConfirmViewController = fromViewController as? CashInConfirmViewController {
            debugPrint("\(#function)CashinComfirm child Coordinator counts --->", cashinConfirmViewController.coordinator?.childCoordinators.count as Any)
            cashinConfirmViewController.coordinator?.childDidFinish()
        }
        if let cashinSuccessViewController = fromViewController as? CashInSuccessViewController {
            debugPrint("\(#function)Cashin Success child Coordinator counts --->", cashinSuccessViewController.coordinator?.childCoordinators.count as Any)
            cashinSuccessViewController.coordinator?.childDidFinish()
        }
        debugPrint("\(#function)NavigationController Counts --->", navigationController.viewControllers.count)
    }

}


/*

override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)

    if parent == nil {
        debugPrint("Back Button pressed.")
        self.alert(isHiddenIcon: true, title: AlertTitle.cancel, message: AlertMessage.cancelMessage, subMessage: AlertSubMessage.cancelSubMessage, cancelAction: {
            debugPrint("Cancel")
        }, proceedAction: {
            debugPrint("Proceed")
        })
    }
}

override func willMove(toParent parent: UIViewController?) {
    super.willMove(toParent: parent)
    if parent == nil {
        self.alert(isHiddenIcon: true, title: AlertTitle.cancel, message: AlertMessage.cancelMessage, subMessage: AlertSubMessage.cancelSubMessage, cancelAction: {
            debugPrint("Cancel")
        }, proceedAction: {
            debugPrint("Proceed")
        })
    }
}

class InterceptableNavigationController: UINavigationController, UINavigationBarDelegate {
    // If a view controller is popped by tapping on the back button, `navigationBar(_:, shouldPop:)` is called first follows by `popViewController(animated:)`.
    // If it is popped by calling to `popViewController(animated:)`, the order reverses and we need this flag to check that.
    private var didCallPopViewController = false
    
    override func popViewController(animated: Bool) -> UIViewController? {
        didCallPopViewController = true
        return super.popViewController(animated: animated)
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        // If this is a subsequence call after `popViewController(animated:)`, we should just pop the view controller right away.
        if didCallPopViewController {
            return originalImplementationOfNavigationBar(navigationBar, shouldPop: item)
        }
        
        // The following code is called only when the user taps on the back button.
        
        guard let vc = topViewController, item == vc.navigationItem else {
            return false
        }
        
        if vc.shouldBePopped(self) {
            return originalImplementationOfNavigationBar(navigationBar, shouldPop: item)
        } else {
            return false
        }
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        didCallPopViewController = false
    }
    
    /// Since `UINavigationController` doesn't publicly declare its conformance to `UINavigationBarDelegate`,
    /// trying to called `navigationBar(_:shouldPop:)` will result in a compile error.
    /// So, we'll have to use Objective-C runtime to directly get super's implementation of `navigationBar(_:shouldPop:)` and call it.
    private func originalImplementationOfNavigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        let sel = #selector(UINavigationBarDelegate.navigationBar(_:shouldPop:))
        let imp = class_getMethodImplementation(class_getSuperclass(InterceptableNavigationController.self), sel)
        typealias ShouldPopFunction = @convention(c) (AnyObject, Selector, UINavigationBar, UINavigationItem) -> Bool
        let shouldPop = unsafeBitCast(imp, to: ShouldPopFunction.self)
        return shouldPop(self, sel, navigationBar, item)
    }
}

extension UIViewController {
    @objc func shouldBePopped(_ navigationController: UINavigationController) -> Bool {
        return true
    }
}

*/
