//
//  DashboardViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit

class DashboardViewController: UIViewController, Storyboarded {
    
    weak var coordinator: DashboardCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        debugPrint("ViewController Stacks: \(self.navigationController?.viewControllers.count as Any)")
        super.viewWillAppear(animated)
    }
    
    @IBAction func cashInBtnAction(_ sender: UIButton) {
        coordinator?.navigateToCashIn()
    }
    
    @IBAction func cashOutBtnAction(_ sender: UIButton) {
        
    }
   
}
