//
//  StoryBoarded.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import Foundation
import UIKit

enum StoryBoard: String {
    case main = "Main"
    case signIn = "SignIn"
    case dashboard = "Dashboard"
    case cashIn = "CashIn"
    case cashinConfirm = "CashInConfirm"
    case cashInSuccess = "CashInSuccess"
    
    var name: String {
        self.rawValue
    }
}

protocol Storyboarded {
    static func instatiate(storyboard: StoryBoard) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instatiate(storyboard: StoryBoard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.name, bundle: Bundle.main)
        return storyboard.instantiateViewController(ofType: Self.self)
    }
    
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
}

extension UIViewController {
    
    static let preventPageSheetPresentation: Void = {
        if #available(iOS 13, *) {
            _swizzling(forClass: UIViewController.self,
                       originalSelector: #selector(present(_: animated: completion:)),
                       swizzledSelector: #selector(_swizzledPresent(_: animated: completion:)))
        }
    }()
    
    @available(iOS 13.0, *)
    @objc private func _swizzledPresent(_ viewControllerToPresent: UIViewController,
                                        animated flag: Bool,
                                        completion: (() -> Void)? = nil) {
        if viewControllerToPresent.modalPresentationStyle == .pageSheet
            || viewControllerToPresent.modalPresentationStyle == .automatic {
            viewControllerToPresent.modalPresentationStyle = .fullScreen
        }
        _swizzledPresent(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    public class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? BaseNavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? BaseTabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    public class func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first
        let topViewController =  getTopViewController(base: keyWindow?.rootViewController)
        return topViewController
    }
    
    class func topViewControllerWithRootViewController(rootViewController: UIViewController?) -> UIViewController? {
        
        if let control = rootViewController as? BaseTabBarController {
            return topViewControllerWithRootViewController(rootViewController: control.selectedViewController)
        } else if let control = rootViewController as? BaseNavigationController {
            return topViewControllerWithRootViewController(rootViewController: control.topViewController)
        } else if let control = rootViewController?.presentedViewController {
            return topViewControllerWithRootViewController(rootViewController: control)
        }
        
        return rootViewController
    }
    
    private class func topViewControllerWithoutCheckPresentedViewController(rootViewController: UIViewController?) -> UIViewController? {
        
        if let control = rootViewController as? BaseTabBarController {
            return topViewControllerWithoutCheckPresentedViewController(rootViewController: control.selectedViewController)
        } else if let control = rootViewController as? BaseNavigationController {
            return topViewControllerWithoutCheckPresentedViewController(rootViewController: control.topViewController)
        }
        
        return rootViewController
    }
    
    class func tabbarController() -> BaseTabBarController? {
        return tabControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController?.presentedViewController)
    }
    
    class func tabControllerWithRootViewController(rootViewController: UIViewController?) -> BaseTabBarController? {
        
        if let control = rootViewController as? BaseTabBarController {
            return control
        } else if let control = rootViewController as? BaseNavigationController {
            
            if let vc = control.viewControllers.first as? BaseTabBarController {
                return vc
            }
            
            if let vc = control.topViewController as? BaseTabBarController {
                return vc
            }
            
            return self.tabControllerWithRootViewController(rootViewController: control.topViewController)
        } else if let control = rootViewController?.presentedViewController {
            return self.tabControllerWithRootViewController(rootViewController: control)
        }
        
        return nil
    }
}

func _swizzling(forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
       let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
