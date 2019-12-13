//
//  GenderEditViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import RealmSwift

class GenderEditViewController: UIViewController {

    private var gender: String?
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var neitherButton: UIButton!
    
    @IBAction func save(_ sender: UIBarButtonItem) {

        RealmServiceAPI.shared.update(Offline.currentUser, with: ["gender" : gender ?? ""]) {
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
    
    @IBAction func selectMale(_ sender: UIButton) {
        maleButton.tintColor = #colorLiteral(red: 0.1083171442, green: 0.8400114775, blue: 0.8413270116, alpha: 1)
        femaleButton.tintColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        neitherButton.setTitleColor(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1), for: .normal)
        
        gender = GenderType.male.rawValue
    }
    
    @IBAction func selectFemale(_ sender: UIButton) {
        maleButton.tintColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        femaleButton.tintColor = #colorLiteral(red: 0.1083171442, green: 0.8400114775, blue: 0.8413270116, alpha: 1)
        neitherButton.setTitleColor(#colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1), for: .normal)
        
        gender = GenderType.female.rawValue
    }
    
    
    @IBAction func selectNeither(_ sender: UIButton) {
        maleButton.tintColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        femaleButton.tintColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        neitherButton.setTitleColor(#colorLiteral(red: 0.1083171442, green: 0.8400114775, blue: 0.8413270116, alpha: 1), for: .normal)
        
        gender = GenderType.neither.rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }
}
