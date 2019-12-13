//
//  AchievementsTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class AchievementsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "achievementCell", for: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAchievementDetails", sender: indexPath)
    }
}
