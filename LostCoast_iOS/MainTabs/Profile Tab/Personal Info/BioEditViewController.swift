//
//  BioEditViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

// TODO: Load bio from database
// TODO: Save bio to database local and online

import UIKit

class BioEditViewController: UIViewController {

    @IBOutlet weak var bioTextView: UITextView!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        RealmServiceAPI.shared.update(Offline.currentUser, with: ["biography" : bioTextView.text ?? ""]) {
            LostCoastUserAPI.shared.uploadProfile(profile: Offline.currentUser, completion: { (error) in
                if let err = error {
                    print(err.localizedDescription)
                }
            })
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bioTextView.becomeFirstResponder()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {        
        tabBarController?.tabBar.isHidden = false
    }

}
