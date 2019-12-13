//
//  HomeTableViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/25/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var rows = 5
    var session = Session() {
        didSet {
            setSyncDate()
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var syncDate: UILabel!
    @IBOutlet weak var syncTime: UILabel!
    
    fileprivate let basicStatNib = UINib(nibName: "BasicStatCell", bundle: nil)
    fileprivate let totalTimeNib = UINib(nibName: "TotalTimeCell", bundle: nil)
    fileprivate let sessionScoreNib = UINib(nibName: "SessionScoreCell", bundle: nil)
    fileprivate var refreshView: RefreshView!
    
    fileprivate var syncRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibs()
        prepare_UI()
        
        let sessions = RealmServiceAPI.shared.realm.objects(Session.self).sorted(byKeyPath: "syncTime", ascending: false)
        if sessions.isEmpty {
            rows = 0
        }
        else {
            self.session = sessions[0]
            setSyncDate()
        }
    }
    
    func setSyncDate() {
        let date = Date(timeIntervalSince1970: session.syncTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        syncDate.text = "\(dateFormatter.string(from: date))"
        dateFormatter.dateFormat = "h:mm a"
        syncTime.text = "\(dateFormatter.string(from: date))"
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 350.0
        }
        return 125.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicStatCell", for: indexPath) as! BasicStatCell
            cell.statResult.text = String(session.waveData.count)
            cell.statName.text = StatType.wavesCaught.rawValue
            cell.statUnit.text = StatUnit.waves.rawValue
            cell.trackingProgressName.text = TrackingProgress.weeklyGoal.rawValue
            cell.trackingProgressValue.text = "\(session.waveData.count) / 100"
            cell.progressBar.progressValue = CGFloat((session.waveData.count / 100) * 100)
            cell.backgroundColor = .clear
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicStatCell", for: indexPath) as! BasicStatCell
            cell.statResult.text = String(SurfSessionDataAPI.shared.getSessionAvgDistance(session: self.session).rounded(toPlaces: 1))
            cell.statName.text = StatType.avgDistance.rawValue
            cell.statUnit.text = StatUnit.feet.rawValue
            cell.trackingProgressName.text = TrackingProgress.personalBest.rawValue
            cell.trackingProgressValue.text = "30"
            cell.progressBar.progressValue = CGFloat((SurfSessionDataAPI.shared.getSessionAvgDistance(session: self.session) / 30) * 100)
            cell.backgroundColor = .clear
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicStatCell", for: indexPath) as! BasicStatCell
            cell.statResult.text = String(SurfSessionDataAPI.shared.getSessionHardestCutback(session: self.session).rounded(toPlaces: 2))
            cell.statName.text = StatType.hardCutBack.rawValue
            cell.statUnit.text = "G"
            cell.trackingProgressName.text = TrackingProgress.personalBest.rawValue
            cell.trackingProgressValue.text = "5.0"
            cell.progressBar.progressValue = CGFloat((SurfSessionDataAPI.shared.getSessionHardestCutback(session: self.session) / 5.0) * 100)
            cell.backgroundColor = .clear
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTimeCell", for: indexPath) as! TotalTimeCell
            cell.statName.text = StatType.totalSessionTime.rawValue
            cell.trackingProgressName.text = TrackingProgress.personalBest.rawValue
            
            let resultTime = SurfSessionDataAPI.shared.getTotalTime(session: self.session)
            
            cell.trackingProgressValue.text = "3 Hour 30 Minutes"
            cell.stat1Value.text = String(resultTime.hour)
            cell.stat1Unit.text = StatUnit.hour.rawValue
            cell.stat2Value.text = String(resultTime.minute)
            cell.stat2Unit.text = StatUnit.minute.rawValue
            cell.backgroundColor = .clear
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionScoreCell", for: indexPath) as! SessionScoreCell
            let scores = SurfSessionDataAPI.shared.getScoreArray(session: self.session)
            print(scores)
            cell.scores = scores
            cell.awakeFromNib()
            cell.backgroundColor = .clear
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "BasicStatCell", for: indexPath)
        }
    }

}

extension HomeTableViewController {
    
    fileprivate func registerNibs() {
        tableView.register(basicStatNib, forCellReuseIdentifier: "BasicStatCell")
        tableView.register(totalTimeNib, forCellReuseIdentifier: "TotalTimeCell")
        tableView.register(sessionScoreNib, forCellReuseIdentifier: "SessionScoreCell")
    }
    
    fileprivate func prepare_UI() {
        tableView.tableFooterView = UIView()
        tableView.refreshControl = syncRefreshControl
        
        getRefreshView()
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
    }
    
    fileprivate func getRefreshView() {
        if let nibRefreshView = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)?.first as? RefreshView {
            refreshView = nibRefreshView
            refreshView.frame = syncRefreshControl.frame
            syncRefreshControl.addSubview(refreshView)
        }
    }
    
    @objc fileprivate func refreshTableView() {
        refreshView.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            let session = SurfSessionDataAPI.shared.generateSession()
            self.session = session
            RealmServiceAPI.shared.create(session)
            Offline.sessionsData.sessions.append(session)
            
            self.refreshView.stopAnimation()
            self.syncRefreshControl.endRefreshing()
            
            self.rows = 5
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
