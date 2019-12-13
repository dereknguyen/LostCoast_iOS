//
//  SyncHistoryTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/27/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import RealmSwift

protocol SyncHistoryDelegate: class {
    func selected(at indexPath: IndexPath, session: Session)
}

class SyncHistoryTableViewController: UITableViewController {
    
    private let syncHistoryNib = UINib(nibName: "SyncHistoryCell", bundle: nil)
    
    weak var delegate: SyncHistoryDelegate?
    
    var sessions: Results<Session>!
    
    class func create() -> SyncHistoryTableViewController {
        let storyboard = UIStoryboard(name: "AnalyticsTab", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SyncHistoryTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        self.tableView.backgroundColor = .clear
        
        tableView.register(syncHistoryNib, forCellReuseIdentifier: "SyncHistoryCell")
        
        sessions = RealmServiceAPI.shared.realm.objects(Session.self).sorted(byKeyPath: "syncTime", ascending: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SyncHistoryCell", for: indexPath) as! SyncHistoryCell
        let session = sessions[indexPath.row]
        
        cell.day.text = SurfSessionDataAPI.shared.getWeekday(session: session)
        cell.date.text = SurfSessionDataAPI.shared.getDate(session: session)
        cell.time.text = SurfSessionDataAPI.shared.getTimeSync(session: session)
        cell.numWavesCaught.text = String(session.waveData.count)
        
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selected(at: indexPath, session: sessions[indexPath.row])
    }
    
}
