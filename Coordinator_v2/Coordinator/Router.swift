
//
//  Coordinator.swift
//  WaveMoney
//
//  Created by Tang Worawitphinyo on 8/9/2565 BE.
//  Copyright © 2565 BE DigitalMoneyMyanmar. All rights reserved.
//

import UIKit

public protocol BaseRouterProtocol {

    var isOnMain: Bool { get }

    func canTransition(with type: Transition) -> Bool

    func transition(_ type: Transition)

    func updateTabItemBadge(tab: Int, badgeValue: String?)
}

public class BaseRouter: BaseRouterProtocol {

    let window: UIWindow

    public init() {
        let bounds = UIScreen.main.bounds
        window = UIWindow.init(frame: bounds)
    }

    public init(window: UIWindow) {
        self.window = window
    }

    public var isOnMain: Bool {
        return window.rootViewController is BaseTabBarController
    }

    public func canTransition(with type: Transition) -> Bool {

        switch type {

        case Transition.push:

            guard let topViewController = UIViewController.topViewController() else {
                return false
            }

            return topViewController.navigationController != nil

        case Transition.open(let url):

            return UIApplication.shared.canOpenURL(url)

        default:
            return true
        }
    }

    public func transition(_ type: Transition) {

        switch type {

        case .root(let scene, let animated):
            if animated {
                let desiredViewController = scene

                let snapshot: UIView = (window.snapshotView(afterScreenUpdates: true))!
                desiredViewController.view.addSubview(snapshot)
                window.rootViewController = desiredViewController

                UIView.animate(withDuration: 0.3, animations: {() in
                    snapshot.layer.opacity = 0
                    snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
                }, completion: {
                    (_: Bool) in
                    snapshot.removeFromSuperview()
                })
            } else {

                window.rootViewController = scene
                window.makeKeyAndVisible()
            }

            break
        case .rootThenModal(let scene, let modalScene, let animated):
            if animated {
                let desiredViewController = scene

                let snapshot: UIView = (window.snapshotView(afterScreenUpdates: true))!
                desiredViewController.view.addSubview(snapshot)

                window.rootViewController = desiredViewController

                UIView.animate(withDuration: 0.3, animations: {() in
                    snapshot.layer.opacity = 0
                    snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
                }, completion: {
                    (_: Bool) in
                    snapshot.removeFromSuperview()

                    guard let topViewController = UIViewController.topViewController() else {
                        fatalError("top view controller not found")
                    }
                    topViewController.present(modalScene, animated: animated, completion: nil)

                })

            } else {

                window.rootViewController = scene
                window.makeKeyAndVisible()

                guard let topViewController = UIViewController.topViewController() else {
                    fatalError("top view controller not found")
                }

                topViewController.present(modalScene, animated: animated, completion: nil)

            }
            break
        case .rootThenSelectTab(let scene, let animated, let index):

            if animated {

                let desiredViewController = scene
                let snapshot: UIView = (window.snapshotView(afterScreenUpdates: true))!
                desiredViewController.view.addSubview(snapshot)

                window.rootViewController = desiredViewController

                UIView.animate(withDuration: 0.3, animations: {() in
                    snapshot.layer.opacity = 0
                    snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
                }, completion: {
                    (_: Bool) in
                    snapshot.removeFromSuperview()

                    let _tabbarController = UIViewController.tabbarController()

                    guard let tabbarController = _tabbarController else {
                        fatalError("tabbar controller not found")
                    }
                    tabbarController.selectedIndex = index
                })

            } else {

                window.rootViewController = scene
                window.makeKeyAndVisible()

                let _tabbarController = UIViewController.tabbarController()

                guard let tabbarController = _tabbarController else {
                    fatalError("tabbar controller not found")
                }
                tabbarController.selectedIndex = index
            }

            break
        case .modal(let scene, let animated):

            guard let topViewController = UIViewController.topViewController() else {
                return
            }
            topViewController.present(scene, animated: animated)

            break
        case .push(let scene, let animated):

            guard let topViewController = UIViewController.topViewController() else {
                return
            }

            guard let navigationController = topViewController.navigationController as? BaseNavigationController else {
                return
            }

            navigationController.pushViewController(scene, animated: animated)

            break
        case .dismiss(let animated, let completion):

            guard let topViewController = UIViewController.topViewController() else {
                fatalError("top view controller not found")
            }

            if let tabBarController = topViewController.navigationController?.tabBarController {
                tabBarController.dismiss(animated: animated) {
                    guard let completion = completion else {
                        return
                    }
                    completion()
                }
            } else if let navigationController = topViewController.navigationController {
                navigationController.dismiss(animated: animated) {
                    guard let completion = completion else {
                        return
                    }
                    completion()
                }
            } else {
                topViewController.dismiss(animated: animated) {
                    guard let completion = completion else {
                        return
                    }
                    completion()
                }
            }

            break
        case .dismissToRoot(let animated):

            guard let rootViewController = window.rootViewController else {
                fatalError("root view controller not found")
            }

            if rootViewController.presentedViewController != nil {

                rootViewController.dismiss(animated: animated) {
                }

            }

            break
        case .pop(let animated):

            guard let topViewController = UIViewController.topViewController() else {
                return
            }

            if let navigationController = topViewController.navigationController {

                navigationController.popViewController(animated: animated)

            }

            break
        case .popToRoot(let animated):

            guard let topViewController = UIViewController.topViewController() else {
                fatalError("top view controller not found")
            }

            if let navigationController = topViewController.navigationController {

                navigationController.popToRootViewController(animated: animated)

            }

            break

        case .popTo(let scene, let animated):

            guard let topViewController = UIViewController.topViewController() else {
                fatalError("top view controller not found")
            }

            if let navigationController = topViewController.navigationController {
                navigationController.popToViewController(scene, animated: animated)
            }

            break
        case .selectTab(let index):

            var tabViewController: BaseTabBarController?

            if let _tabBar = UIViewController.tabbarController() {
                tabViewController = _tabBar
            } else {
                tabViewController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
            }

            guard tabViewController != nil else {
                fatalError("tab view controller not found")
            }

            if tabViewController == nil {
                tabViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
            }

            UIView.animate(withDuration: 0.1, animations: {
                tabViewController?.selectedIndex = index
            }) { (_) in
                //
            }

            break
        case .open(let url):

            let app = UIApplication.shared

            if app.canOpenURL(url) {

                if #available(iOS 10.0, *) {
                    app.open(url, options: [:]) { (_) in
                        //
                    }
                } else {
                    app.openURL(url)
                }

            }
        }
    }

    public func updateTabItemBadge(tab: Int, badgeValue: String?) {
        var tabViewController: BaseTabBarController?

        if let _tabBar = UIViewController.tabbarController() {
            tabViewController = _tabBar
        } else {
            tabViewController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        }

        if let tabViewController = tabViewController,
            let tabItems = tabViewController.tabBar.items,
            tabItems.count > tab {
            tabViewController.viewControllers?[tab].tabBarItem.badgeValue = badgeValue
        }
    }
}

