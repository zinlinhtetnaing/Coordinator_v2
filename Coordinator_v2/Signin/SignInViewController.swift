//
//  SignInViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit

class SignInViewController: UIViewController, Storyboarded {
    
    weak var coordinator: SignInCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint(self.navigationController?.viewControllers)
    }
    
    @IBAction func gotoDashboardBtnAction(_ sender: UIButton) {
        coordinator?.navigateToDashboard()
    }
    
    @IBAction func backToSplashBtnAction(_ sender: Any) {
        coordinator?.dismiss()
    }
    
}
