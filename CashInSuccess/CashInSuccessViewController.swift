//
//  CashInSuccessViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit

class CashInSuccessViewController: UIViewController, Storyboarded {
    
    weak var coordinator: CashInSuccessCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func gotoDashboardBtnAction(_ sender: Any) {
        coordinator?.popToRootView()
    }
    
    @IBAction func backToCashInBtnAction(_ sender: Any) {
        coordinator?.popToCashInView()
    }
    
}
