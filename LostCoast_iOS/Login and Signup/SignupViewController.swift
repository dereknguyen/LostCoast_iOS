//
//  SignupViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/16/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    private var embeddedController: SignupInfoTableViewController?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func signupUserWithEmail(_ sender: UIButton) {
        
        // Error checking textfield for empty textfield
        guard let email = embeddedController?.emailTF.getText(from: self, type: .email, process: .signUp) else { return }
        guard let password = embeddedController?.passwordTF.getText(from: self, type: .password, process: .signUp) else { return }
        
        // Show loading
        ProgressHUD.shared.show(in: self.view, title: "Signing Up", animated: true)
        
        // Signup via Firebase Singleton
        FirebaseServiceAPI.shared.signup(email: email, password: password) {
            [weak self] (authError) in
            
            guard let this = self else { return }
            
            // End loading
            ProgressHUD.shared.dismiss(animated: true)
            
            if let error = authError {
                Alert.showAlert(in: this,
                                title: "Sign Up Error",
                                message: error.localizedDescription,
                                handler: nil)
                return
            }
            
            DispatchQueue.main.async {
                // Segue to create account
                this.performSegue(withIdentifier: "toCreateAccountFromSignUp", sender: nil)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

// MARK: Communication with embedded viewcontroller
extension SignupViewController {
    
    // Get reference to the embedded tableview controller
    func saveContainer(viewController reference: SignupInfoTableViewController) {
        self.embeddedController = reference
    }
}
