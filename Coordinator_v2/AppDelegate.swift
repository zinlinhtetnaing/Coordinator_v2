//
//  AppDelegate.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
       
        
        let navigationController = BaseNavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController /// BaseTabBarViewController()
       
        coordinator = MainCoordinator(window?.rootViewController as! BaseNavigationController)
        coordinator?.start()
        
        window?.makeKeyAndVisible()
    
        return true
        
    }

}
