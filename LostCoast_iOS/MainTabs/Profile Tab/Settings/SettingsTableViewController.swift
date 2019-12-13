//
//  SettingsTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func logOut(_ sender: UIButton) {
        
        Alert.showAlertWithCancel(in: self, title: "Logging Out", message: "Are you sure you want to be logged out?", actionTitle: "Log out", style: .destructive) { (_) in
            FirebaseServiceAPI.shared.logout { [weak self] (error) in
                guard let this = self else { return }
                if let err = error {
                    Alert.showAlert(in: this, title: "Log Out Error", message: err.localizedDescription, handler: nil)
                    return
                }
                
                // TODO: - Clear Saved Data
                RealmServiceAPI.shared.removeLocalData()
                
                DispatchQueue.main.async {
                    UserDefaults.standard.set(false, forKey: WindowSwitcher.isSignedIn)
                    WindowSwitcher.updateRootViewController()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        tableView.tableFooterView = UIView()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        logoutButton.addGradient(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 1, y: 0), colors: [#colorLiteral(red: 1, green: 0.2666666667, blue: 0.2784313725, alpha: 1).cgColor, #colorLiteral(red: 0.02352941176, green: 0.1568627451, blue: 0.2980392157, alpha: 1).cgColor])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarView?.backgroundColor = .clear
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 7 }
}
