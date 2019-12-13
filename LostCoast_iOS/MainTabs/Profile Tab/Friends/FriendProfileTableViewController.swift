//
//  FriendProfileTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/25/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class FriendProfileTableViewController: UITableViewController {

    private let headerHeight = UIScreen.main.bounds.width
    
    @IBOutlet weak var headerView: DetailHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader_UI()
        setupTableView_UI()
        title = "bigwix36"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    

    override func willMove(toParentViewController parent: UIViewController?) {

        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            performSegue(withIdentifier: "toAchievements", sender: indexPath)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Calculate color for status bar and navigation bar background color base on scroll
        let bgColor = UIColor(red: 15 / 255,
                              green: 15 / 255,
                              blue: 15 / 255,
                              alpha: (scrollView.contentOffset.y + headerHeight) / 175)
        
        navigationController?.navigationBar.backgroundColor = bgColor
        UIApplication.shared.statusBarView?.backgroundColor = bgColor
        
        updateHeaderView_UI()
    }
}

extension FriendProfileTableViewController {
    
    private func setupTableView_UI() {
        self.tableView.tableFooterView = UIView()
    }
    
    private func setupHeader_UI() {
        
        headerView = tableView.tableHeaderView as! DetailHeaderView
        
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -headerHeight)
        
        updateHeaderView_UI()
    }
    
    private func updateHeaderView_UI() {
        
        var headerRect = CGRect(x: 0, y: -headerHeight, width: headerHeight, height: headerHeight)
        
        if tableView.contentOffset.y < -headerHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        self.headerView.frame = headerRect
    }
}
