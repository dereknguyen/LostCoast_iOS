//
//  ProfileTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/22/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView { }

class ProfileTableViewController: UITableViewController {

    private let headerHeight = UIScreen.main.bounds.width
    
    @IBOutlet weak var headerView: DetailHeaderView!
    @IBOutlet weak var profileImageView: CustomImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var highlightStatLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderHeight()
        setup_UI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNameLabel()
        setupLocationLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarView?.backgroundColor = .clear
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

// MARK: - Table view data source
extension ProfileTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 4 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}

// MARK: - Table view UI
extension ProfileTableViewController {
    
    private func setup_UI() {
        tableView.tableFooterView = UIView()
        
        profileImageView.loadImage(urlString: Offline.currentUser.imageURL)

        setupNameLabel()
        setupLocationLabel()
    }
    
    private func setupLocationLabel() {
        if Offline.currentUser.state.count > 0 {
            userLocationLabel.text = "\(Offline.currentUser.state), \(Offline.currentUser.country)"
        }
        else {
            userLocationLabel.text = "\(Offline.currentUser.country)"
        }
    }
    
    private func setupNameLabel() {
        fullNameLabel.text = "\(Offline.currentUser.firstName) \(Offline.currentUser.lastName)"
    }
    
    
    private func setupHeaderHeight() {
        
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
