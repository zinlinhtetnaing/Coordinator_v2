//
//  SettingsViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import UIKit

class SettingsViewController: UIViewController {

    weak var coordinator: SettingsCoordinator?
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: 45)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(self.logoutBtnAction(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(logoutButton)
        logoutButton.center = view.center
    }
    
    @objc func logoutBtnAction(_ sender: UIButton) {
        coordinator?.logout()
    }

}
