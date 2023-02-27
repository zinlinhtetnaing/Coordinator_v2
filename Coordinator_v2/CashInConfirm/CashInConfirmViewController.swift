//
//  CashInConfirmViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit

class CashInConfirmViewController: UIViewController, Storyboarded {
    
    weak var coordinator: CashInConfirmCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func cashinSuccessBtnAction(_ sender: UIButton) {
        coordinator?.navigateToCashInSuccess()
    }
    
    @IBAction func goToCashInBtnAction(_ sender: UIButton) {
        coordinator?.backToCashIn()
    }
    
}
