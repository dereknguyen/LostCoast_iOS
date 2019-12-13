//
//  EditTextFieldViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

// TODO: Set textfield to local database value
// TODO: Save to database and local

import UIKit

class EditTextFieldViewController: UIViewController {

    var label: String?
    
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func saveInfo(_ sender: UIBarButtonItem) {
        RealmServiceAPI.shared.update(Offline.currentUser, with: [self.label ?? "" : textField.text ?? ""]) {
            LostCoastUserAPI.shared.uploadProfile(profile: Offline.currentUser, completion: { (error) in
                if let err = error {
                    print(err.localizedDescription)
                }
            })
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fieldLabel.text = self.label?.camelCaseToWords()
        
        self.title = self.label?.camelCaseToWords().capitalized
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }

}
