//
//  CashInViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit

class CashInViewController: UIViewController, Storyboarded {
    
    weak var coordinator: CashInCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cashInConfirmBtnAction(_ sender: UIButton) {
        coordinator?.navigateToCashInConfirm()
    }
    
}
