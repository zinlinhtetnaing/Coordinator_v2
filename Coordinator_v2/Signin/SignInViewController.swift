//
//  SignInViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 10/08/2022.
//

import UIKit
import resource_spm


class SignInViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var resourcesImage: UIImageView!
    
    weak var coordinator: SignInCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint(self.navigationController?.viewControllers)
        UserDefaults.standard.removeObject(forKey: "networkresult")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.setGradient()
    }
    
    @IBAction func gotoDashboardBtnAction(_ sender: UIButton) {
        navigateAndFetchData()
    }
    
    @IBAction func backToSplashBtnAction(_ sender: Any) {
        coordinator?.dismiss()
    }
    
    func navigateAndFetchData() {
        // Start navigation immediately on the main thread
        navigateToNextScreen()
        
        // Perform network call on a background queue
        DispatchQueue.global(qos: .background).async {
            do {
                let result = try self.makeNetworkCall()
                // Process the result if needed
                self.handleNetworkResult(result)
            } catch {
                // Handle error
            }
        }
    }

    func navigateToNextScreen() {
        // Your navigation logic here
        print("already navigated to next screen")
        coordinator?.navigateToDashboard()
    }

    func makeNetworkCall() throws -> String {
        // Simulate a network call
        sleep(10)
        return "Network data"
    }

    func handleNetworkResult(_ result: String) {
        // Handle the network result
        print("newtwork response: \(result)")
        UserDefaults.standard.setValue(result, forKey: "networkresult")
        
    }

    
}
