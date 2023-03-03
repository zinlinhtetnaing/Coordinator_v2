//
//  Transition.swift
//  WaveMoney
//
//  Created by Tang Worawitphinyo on 8/9/2565 BE.
//  Copyright © 2565 BE DigitalMoneyMyanmar. All rights reserved.
//

import Foundation
import UIKit

public enum Transition {
    case root(scene: UIViewController, animated: Bool)
    case rootThenModal(scene: UIViewController, modalScene: UIViewController, animated: Bool)
    case rootThenSelectTab(scene: UIViewController, animated: Bool, index: Int)
    case modal(scene: UIViewController, animated: Bool)
    case dismiss(animated: Bool, (() -> Void)? = nil)
    case dismissToRoot(animated: Bool)
    case push(scene: UIViewController, animated: Bool)
    case pop(animated: Bool)
    case popToRoot(animated: Bool)
    case popTo(scene: UIViewController, animated: Bool)
    case selectTab(index: Int)
    case open(url: URL)
}

