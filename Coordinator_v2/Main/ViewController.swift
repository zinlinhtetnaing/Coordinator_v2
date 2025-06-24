//
//  ViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit
import XKeychainService
import XBiometricLocalAuthentication
import LocalAuthentication

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
    let devKeychain = XKeychainService(service: "dev")
    let sitKeychain = XKeychainService(service: "sit")
    let prodKeychain = XKeychainService(service: "prod")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var enrolledBiometric: Bool {
        var error: NSError?
        let context = LAContext()
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    @IBAction func signinBtnAction(_ sender: UIButton) {
        
//        self.devKeychain.set(for: .dynamicIV, item: "dev12345")
        
//        debugPrint("DEV data.", self.devKeychain.read(for: .dynamicIV) ?? "can't read")
//        debugPrint("SIT data.", self.sitKeychain.read(for: .dynamicIV) ?? "can't read")
//        debugPrint("Prod data.", self.prodKeychain.read(for: .dynamicIV) ?? "can't read")
//        debugPrint("Prod data with dev service", self.devKeychain.read(for: .userId) ?? "can't read")
//        debugPrint("Prod data with prod service", self.prodKeychain.read(for: .userId) ?? "can't read")
//        
//        debugPrint("is Enrolled biometric: \(enrolledBiometric)")
//        
//        XBiometricLocalAuthentication.shared.authenticateWithBioMetrics { resut in
//            switch resut {
//            case .success:
//                self.coordinator?.signIn()
//                self.devKeychain.set(for: .dynamicIV, item: "dev12345")
//                self.sitKeychain.set(for: .dynamicIV, item: "sit12345")
//                
//                self.prodKeychain.set(for: .dynamicIV, item: "prod12345")
//                self.prodKeychain.set(for: .userId, item: "prodTestiOS")
//                
//                debugPrint("DEV data.", self.devKeychain.read(for: .dynamicIV) ?? "can't read")
//                debugPrint("SIT data.", self.sitKeychain.read(for: .dynamicIV) ?? "can't read")
//                debugPrint("Prod data.", self.prodKeychain.read(for: .dynamicIV) ?? "can't read")
//                debugPrint("Prod data with dev service", self.devKeychain.read(for: .userId) ?? "can't read")
//                debugPrint("Prod data with prod service", self.prodKeychain.read(for: .userId) ?? "can't read")
//                
//            case .failure(let errorMessage):
//                let alertController = UIAlertController(title: "Biometric Error", message: errorMessage.errorDescription.description, preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: .default) { action -> Void in
//                    // Put your code here
//                })
//                self.devKeychain.deleteAllItems()
//                self.prodKeychain.deleteAllItems()
//                self.sitKeychain.deleteAllItems()
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
        self.coordinator?.signIn()
        
    }
    
}
