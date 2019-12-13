//
//  BLEDeviceTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class BLEDeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class BLEDeviceTableViewController: UITableViewController {

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Available Devices"
        tableView.tableFooterView = UIView()
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }


}
