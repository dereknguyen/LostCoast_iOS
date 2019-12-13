//
//  FriendsTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/25/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendUsername: UILabel!
    @IBOutlet weak var friendStat1: UILabel!
    @IBOutlet weak var friendStat2: UILabel!
    
}

class FriendsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        searchBar.searchBarStyle = .minimal
        searchBar.setSearchField(color: #colorLiteral(red: 0.1083171442, green: 0.8400114775, blue: 0.8413270116, alpha: 1))
        
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toFriendProfile", sender: indexPath)
    }

}
