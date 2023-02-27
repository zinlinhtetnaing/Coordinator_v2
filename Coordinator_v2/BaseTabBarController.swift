//
//  BaseTabBarController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    lazy var dashboardCoordinator = DashboardCoordinator(BaseNavigationController())
    lazy var qrCoordinator = QRPayCoordinator(BaseNavigationController())
    lazy var transactionsCoordinator = TransactionsCoordinator(BaseNavigationController())
    lazy var settingsCoordinator = SettingsCoordinator(BaseNavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        coordinatorsStart()
    }
    
    private func coordinatorsStart() {
        dashboardCoordinator.start()
        qrCoordinator.start()
        transactionsCoordinator.start()
        settingsCoordinator.start()
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = .systemPink
        tabBar.tintColor = .systemTeal
        tabBar.unselectedItemTintColor = .systemGray
        selectedIndex = 0
        
        viewControllers = [
            createTabBarItem(tabBarTitle: "Home", tabBarImage: "", navigationController: dashboardCoordinator.navigationController),
            createTabBarItem(tabBarTitle: "QR Pay", tabBarImage: "", navigationController: qrCoordinator.navigationController),
            createTabBarItem(tabBarTitle: "Transactions", tabBarImage: "", navigationController: transactionsCoordinator.navigationController),
            createTabBarItem(tabBarTitle: "Settings", tabBarImage: "", navigationController: settingsCoordinator.navigationController)
        ]
    }
    
    private func createTabBarItem(tabBarTitle: String, tabBarImage: String, navigationController: BaseNavigationController) -> BaseNavigationController {
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = UIImage(named: tabBarImage)
        return navigationController
    }
    
}
