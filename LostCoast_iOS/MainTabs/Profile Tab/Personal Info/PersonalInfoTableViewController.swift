//
//  PersonalInfoTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/22/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import RealmSwift

class PersonalInfoTableViewController: UITableViewController {

    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    let editTextFieldIndexRow: [Int] = [1, 2]
    let fieldLabels: [String] = [
        "",
        "firstName",
        "lastName",
        "gender",
        "birthday",
        "",
        "location",
        "",
        "bio"
    ]
    
    var notificationToken: NotificationToken?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        
        setupLabels()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setupLabels()
        tableView.tableFooterView = UIView()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        notificationToken = RealmServiceAPI.shared.realm.observe({ [weak self] (notification, realm) in
            guard let this = self else { return }
            this.setupLabels()
        })
        
        RealmServiceAPI.shared.observeRealmError(in: self) { (error) in
            print(error ?? "No Error")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notificationToken?.invalidate()
        RealmServiceAPI.shared.stopObservingErrors(in: self)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarView?.backgroundColor = .clear
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        
        if editTextFieldIndexRow.contains(indexPath.row) {
            let destination = segue.destination as! EditTextFieldViewController
        
            destination.label = fieldLabels[indexPath.row]
        }
    }
    
    private func setupLabels() {
        firstnameLabel.text = Offline.currentUser.firstName
        lastnameLabel.text = Offline.currentUser.lastName
        usernameLabel.text = Offline.currentUser.username
        genderLabel.text = Offline.currentUser.gender.capitalized
        birthdayLabel.text = Offline.currentUser.birthday.getText()
        stateLabel.text = Offline.currentUser.state
        countryLabel.text = Offline.currentUser.country
        bioLabel.text = Offline.currentUser.biography
        tableView.reloadData()
    }
        
}

extension PersonalInfoTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 10 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension PersonalInfoTableViewController {
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if editTextFieldIndexRow.contains(indexPath.row) {
            performSegue(withIdentifier: "toTextEdit", sender: indexPath)
        }
        
    }
    
}
