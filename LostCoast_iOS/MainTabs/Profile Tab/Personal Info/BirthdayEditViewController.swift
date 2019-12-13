//
//  BirthdayEditViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class BirthdayEditViewController: UIViewController {

    @IBOutlet weak var birthdatePicker: UIDatePicker!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
        
        setupDOBPicker_UI()
    }

    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }
}

extension BirthdayEditViewController {
    private func setupDOBPicker_UI() {
        self.birthdatePicker.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "textColor")
        self.birthdatePicker.datePickerMode = .date
    }
}
