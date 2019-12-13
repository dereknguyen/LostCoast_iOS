//
//  LoginViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/16/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var embeddedController: LoginInfoTableViewController?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func loginUser(_ sender: UIButton) {
        
        guard let email = self.embeddedController?.emailTextField.getText(from: self, type: .email, process: .logIn) else { return }
        guard let password = self.embeddedController?.passwordTextField.getText(from: self, type: .password, process: .logIn) else { return }
        
        ProgressHUD.shared.show(in: self.view, title: "Signing In", animated: true)
        FirebaseServiceAPI.shared.login(email: email, password: password) { [weak self] authError in
            
            guard let this = self else { return }
            
            if let error = authError {
                Alert.showAlert(in: this, title: "Authentication Error", message: error.localizedDescription, handler: nil)
                
                DispatchQueue.main.async {
                    ProgressHUD.shared.dismiss(animated: true)
                }
                return
            }
            
            LostCoastUserAPI.shared.checkUserProfileExist { (userExist, error) in
    
                DispatchQueue.main.async {
                    ProgressHUD.shared.dismiss(animated: true)
                }
                
                if let error = error {
                    Alert.showAlert(in: this, title: "Checking User Error", message: error.localizedDescription, handler: nil)
                    return
                }
                
                if userExist {
                    LostCoastUserAPI.shared.observeCurrentUser(completion: { (user, error) in
                        guard let user = user else { return }
                        
                        Offline.currentUser = user
                        RealmServiceAPI.shared.create(Offline.currentUser)
                        
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(true, forKey: WindowSwitcher.isSignedIn)
                            WindowSwitcher.updateRootViewController()
                        }
                    })
                }
                else {
                    DispatchQueue.main.async {
                        this.performSegue(withIdentifier: "toCreateProfileFromLogin", sender: nil)
                    }
                }
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

extension LoginViewController {
    
    func saveContainer(viewController reference: LoginInfoTableViewController) {
        self.embeddedController = reference
    }
}



