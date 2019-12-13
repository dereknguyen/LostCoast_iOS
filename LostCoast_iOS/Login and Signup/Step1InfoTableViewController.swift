//
//  Step1InfoTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/16/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class Step1InfoTableViewController: UITableViewController {
    
    // MARK: - Privates Properties
    var dateOfBirth: TimeInterval?      /// Saved user chosen date from UIDatePicker
    
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBAction func dateDidChange(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM  /  dd  /  yyyy"
        birthdateLabel.text = "\(dateFormatter.string(from: birthdatePicker.date))"
        birthdateLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.8117647059, blue: 0.8039215686, alpha: 1)
        self.dateOfBirth = birthdatePicker.date.timeIntervalSince1970
    }
    
    
    // MARK: - View's Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // On storyboard, this is part of a container view.
        // In order to access it from the main view controller,
        //     we have to set the parent controller.
        let parentViewController = self.parent as! Step1ViewController
        parentViewController.saveContainer(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView_UI()
        self.setupDOBPicker_UI()
        
        // Hide DOB picker whenever other textfield is selected
        self.firstNameTF.addTarget(self, action: #selector(hideDOBDatePicker), for: .editingDidBegin)
        self.lastNameTF.addTarget(self, action: #selector(hideDOBDatePicker), for: .editingDidBegin)
        self.usernameTF.addTarget(self, action: #selector(hideDOBDatePicker), for: .editingDidBegin)
    }
}

// MARK: - Tableview's Datasource
extension Step1InfoTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 5 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 4 {
            let height: CGFloat = birthdatePicker.isHidden ? 0.0 : 216.0
            return height
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}

// MARK: - Tableview's Delegate
extension Step1InfoTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datePickerIndexPath = IndexPath(row: 3, section: 0)
        
        // If birthday field is selected
        if datePickerIndexPath == indexPath {
            self.firstNameTF.endEditing(true)
            self.lastNameTF.endEditing(true)
            self.usernameTF.endEditing(true)
            
            birthdatePicker.isHidden = !birthdatePicker.isHidden
            
            UIView.animate(withDuration: 0.3) {
                
                self.tableView.beginUpdates()
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.tableView.endUpdates()
            }
        }
    }
}

// MARK: - Private Methods Extensions
extension Step1InfoTableViewController {
    
    /// Hide Date of Birth picker cell
    @objc private func hideDOBDatePicker() {
        if !self.birthdatePicker.isHidden {
            self.birthdatePicker.isHidden = true
            
            UIView.animate(withDuration: 0.3) {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }
    
}

// MARK: - UI Setup Private Methods
extension Step1InfoTableViewController {
    
    private func setupDOBPicker_UI() {
        self.birthdatePicker.setValue(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), forKey: "textColor")
        self.birthdatePicker.datePickerMode = .date
        self.birthdatePicker.isHidden = true
    }
    
    private func setupTableView_UI() {
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.tableFooterView = UIView()
    }
    
}
