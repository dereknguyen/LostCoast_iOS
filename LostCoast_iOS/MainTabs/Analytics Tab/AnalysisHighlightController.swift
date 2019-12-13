//
//  AnalysisHighlightController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/27/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class AnalysisHighlightController: UICollectionViewController {

    var session: Session?

    
    private var basicStatCell = UINib(nibName: "AnalysisHighlightCell", bundle: nil)
    private var timeStatCell = UINib(nibName: "TotalTimeCollectionViewCell", bundle: nil)
    private var wavesCell = UINib(nibName: "WavesCaughtCollectionViewCell", bundle: nil)
    private let categories = ["Waves Caught", "Distance", "Cutback Force", "Surf Scores", "Time per wave"]
    private let unit = ["waves", "feet", "G", "", "sec"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView?.register(basicStatCell, forCellWithReuseIdentifier: "AnalysisHighlightCell")
        self.collectionView?.register(timeStatCell, forCellWithReuseIdentifier: "TimeCell")
        self.collectionView?.register(wavesCell, forCellWithReuseIdentifier: "WavesCell")


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AnalysisHighlightHeaderView", for: indexPath) as! AnalysisHighlightHeaderView
            if let sesh = session {
                headerView.day.text = SurfSessionDataAPI.shared.getWeekday(session: sesh)
                headerView.date.text = SurfSessionDataAPI.shared.getDate(session: sesh)
                headerView.time.text = SurfSessionDataAPI.shared.getTimeSync(session: sesh)
            }
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sesh = session else { return collectionView.cellForItem(at: indexPath)!}
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WavesCell", for: indexPath) as! WavesCaughtCollectionViewCell
            cell.wavesCaught = sesh.waveData.count
            cell.awakeFromNib()
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisHighlightCell", for: indexPath) as! AnalysisHighlightCell
            cell.categoryLabel.text = categories[indexPath.row]
            cell.statUnit.text = unit[indexPath.row]
            cell.resultToDisplay = SurfSessionDataAPI.shared.getDistances(session: sesh)
            cell.statValue.text = String(SurfSessionDataAPI.shared.getSessionAvgDistance(session: sesh).rounded(toPlaces: 1))
            cell.awakeFromNib()
            cell.backgroundColor = .clear
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisHighlightCell", for: indexPath) as! AnalysisHighlightCell
            cell.categoryLabel.text = categories[indexPath.row]
            cell.statUnit.text = unit[indexPath.row]
            cell.resultToDisplay = SurfSessionDataAPI.shared.getCutbackForces(session: sesh)
            cell.statValue.text = String(SurfSessionDataAPI.shared.getAvgCutbackForce(session: sesh))
            cell.awakeFromNib()
            cell.backgroundColor = .clear
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisHighlightCell", for: indexPath) as! AnalysisHighlightCell
            cell.categoryLabel.text = categories[indexPath.row]
            cell.statUnit.text = unit[indexPath.row]
            cell.resultToDisplay = SurfSessionDataAPI.shared.getWaveAvgScore(session: sesh)
            cell.statValue.text = String(SurfSessionDataAPI.shared.getScoreAvg(session: sesh))
            cell.awakeFromNib()
            cell.backgroundColor = .clear
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisHighlightCell", for: indexPath) as! AnalysisHighlightCell
            cell.categoryLabel.text = categories[indexPath.row]
            cell.statUnit.text = unit[indexPath.row]
            cell.resultToDisplay = SurfSessionDataAPI.shared.getTimePerWaves(session: sesh)
            cell.statValue.text = String(SurfSessionDataAPI.shared.getAvgSecondsPerWaves(session: sesh))
            cell.awakeFromNib()
            cell.backgroundColor = .clear
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalysisHighlightCell", for: indexPath) as! AnalysisHighlightCell
            cell.categoryLabel.text = categories[indexPath.row]
            cell.statUnit.text = unit[indexPath.row]
            cell.awakeFromNib()
            cell.backgroundColor = .clear
            return cell
        }
    }
}

extension AnalysisHighlightController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 85.0)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 250.0)
    }
    

    
}
