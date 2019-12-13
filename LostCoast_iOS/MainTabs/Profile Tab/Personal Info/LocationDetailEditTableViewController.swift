//
//  LocationDetailEditTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

protocol LocationDetailEditDelegate {
    func selectedData(title: String?, location: String?)
}

class LocationDetailEditTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: LocationDetailEditDelegate?
    
    var selected = String()
    var data = [String]()
    var currData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currData = data
        
        tableView.tableFooterView = UIView()
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        searchBar.searchBarStyle = .minimal
        searchBar.setSearchField(color: #colorLiteral(red: 0.1083171442, green: 0.8400114775, blue: 0.8413270116, alpha: 1))
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationNameCell", for: indexPath) as! LocationTableViewCell
        
        cell.locationLabel.text = currData[indexPath.row]
        
        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selected = currData[indexPath.row]
        delegate?.selectedData(title: self.title, location: self.selected)
        navigationController?.popViewController(animated: true)
    }
}

extension LocationDetailEditTableViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            currData = data
            tableView.reloadData()
            return
        }
        
        currData = data.filter({ data -> Bool in
            guard let text = searchBar.text?.lowercased() else { return false}
            return data.lowercased().contains(text)
        })
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
