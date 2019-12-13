//
//  Step1ViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/16/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class Step1ViewController: UIViewController {
    
    private var embeddedController: Step1InfoTableViewController?
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImage: UIImageView!    // Background Wallpaper
    @IBOutlet weak var continueButton: UIButton!        // Continue to next step button
    @IBOutlet weak var errorLabel: UILabel!             // Error label - unused for now
    
    
    @IBAction func continueToStep2(_ sender: UIButton) {
        // [1] Check all text field are filled out
        guard let email = FirebaseServiceAPI.shared.getEmail(),
              let uid = FirebaseServiceAPI.shared.getUID(),
              let firstName = embeddedController?.firstNameTF.text,
              let lastName = embeddedController?.lastNameTF.text,
              let username = embeddedController?.usernameTF.text,
              let birthday = embeddedController?.dateOfBirth
        else {
            Alert.showAlert(in: self,
                            title: "Missing Information",
                            message: "Please fill out the entire form.",
                            handler: nil)
            return
        }
        
        // [2] Check if username exist in the database, if yes, prompt user to pick another one
        ProgressHUD.shared.show(in: self.view, title: "Checking Username", animated: true)
        LostCoastUserAPI.shared.checkUsernameExist(username: username) { [weak self] isExist in
            guard let this = self else { return }
            
            DispatchQueue.main.async {
                ProgressHUD.shared.dismiss(animated: true)
            }
            
            if !isExist {
                
                // [3] Save profile offline
                Offline.currentUser.firstName = firstName
                Offline.currentUser.lastName = lastName
                Offline.currentUser.username = username
                Offline.currentUser.email = email
                Offline.currentUser.uid = uid
                Offline.currentUser.birthday = birthday
                
                DispatchQueue.main.async {
                    this.performSegue(withIdentifier: "Step1ToStep2", sender: nil)
                }
            }
            else {
                Alert.showAlert(in: this,
                                title: "Username Exist",
                                message: "The username you've chosen is already in use by another user. Please choose another unique username.",
                                handler: nil)
            }
        }
    }
    
    
    @IBAction func cancelCreateAccount(_ sender: UIButton) {
        Alert.showAlertWithCancel(in: self,
                                  title: "Are you sure?",
                                  message: "You will be logged out, but you log in back later to resume create account.",
                                  actionTitle: "Yes") {
            [weak self] (_) in
            guard let this = self else { return }
                                    
            DispatchQueue.main.async {
                ProgressHUD.shared.show(in: this.view, title: "Logging Out", animated: true)
            }
                                    
            FirebaseServiceAPI.shared.logout(completion: { (error) in
                
                DispatchQueue.main.async {
                    ProgressHUD.shared.dismiss(animated: true)
                }
                
                if let err = error {
                    DispatchQueue.main.async {
                        Alert.showAlert(in: this, title: "Log Out Error", message: err.localizedDescription, handler: nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    this.performSegue(withIdentifier: "unwindFomrSetup", sender: nil)
                }
            })
        }
    }
    
    // MARK: - Unwind Segue
    @IBAction func unwindToStep1(_ sender: UIStoryboardSegue) { }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension Step1ViewController {
    func saveContainer(viewController reference: Step1InfoTableViewController) {
        self.embeddedController = reference
    }
}
