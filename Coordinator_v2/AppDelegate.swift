//
//  AppDelegate.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString{
            debugPrint("DeviceID", uuid)
//            "4682E50C-B56E-4A56-A549-410064C91336"
//            "E032F701-7BF6-4871-8C0E-D3ED32B85631"
        }
        
        IQKeyboardManager.shared.enable = true
        
        let navigationController = BaseNavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController /// BaseTabBarViewController()
       
        coordinator = MainCoordinator(window?.rootViewController as! BaseNavigationController)
        coordinator?.start()
        
        window?.makeKeyAndVisible()
    
        return true
        
    }

}
