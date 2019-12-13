//
//  LocationEditTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class LocationEditTableViewController: UITableViewController {

    var rowCount = 2
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if rowCount == 1 {
            RealmServiceAPI.shared.update(Offline.currentUser, with: [
                "country" : countryLabel.text ?? "",
                "state" : ""
                ], completion: {
                LostCoastUserAPI.shared.uploadProfile(profile: Offline.currentUser, completion: { (error) in
                    if let err = error {
                        print(err.localizedDescription)
                    }
                })
            })
        }
        else {
            RealmServiceAPI.shared.update(Offline.currentUser, with: [
                "country" : countryLabel.text ?? "",
                "state" : stateLabel.text ?? ""
            ]) {
                LostCoastUserAPI.shared.uploadProfile(profile: Offline.currentUser, completion: { (error) in
                    if let err = error {
                        print(err.localizedDescription)
                    }
                })
            }
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tabBarController?.tabBar.isHidden = true
        
        countryLabel.text = Offline.currentUser.country
        stateLabel.text = Offline.currentUser.state
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if countryLabel.text != "United States" {
            rowCount = 1
        }
        else {
            rowCount = 2
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        
        let destination = segue.destination as! LocationDetailEditTableViewController
        destination.delegate = self
        
        if indexPath.row == 0 {
            destination.title = "Countries"
            destination.data = Location.countries
        }
        else if indexPath.row == 1 {
            destination.title = "States"
            destination.data = Location.states
        }
        
    }

    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }
}

extension LocationEditTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return rowCount }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toLocationDetailEdit", sender: indexPath)
    }
}

extension LocationEditTableViewController: LocationDetailEditDelegate {
    
    func selectedData(title: String?, location: String?) {
        if let title = title {
            if title == "Countries" {
                countryLabel.text = location
            }
            else if title == "States" {
                stateLabel.text = location
            }
        }
    }
}
