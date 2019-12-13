//
//  RecordCollectionViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/27/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit


class RecordCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let categoryCellNib = UINib(nibName: "RecordCategoryCell", bundle: nil)
    private let categories = ["DISTANE", "TOTAL TIME", "WAVES", "CUTBACK", "SURF"]
    private let categoriesSub = ["PER WAVES", "PER SESSION", "CAUGHT", "POWER", "SCORE"]
    private let icons = ["distance_icon", "time_icon", "wave_icon", "surf_icon", "shaka_icon"]
    
    class func create() -> RecordCollectionViewController {
        let storyboard = UIStoryboard(name: "AnalyticsTab", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RecordCollectionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(categoryCellNib, forCellWithReuseIdentifier: "RecordCategoryCell")

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordCategoryCell", for: indexPath) as! RecordCategoryCell
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categorySubLabel.text = categoriesSub[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.categoryLeftIcon.image = UIImage(named: icons[indexPath.row])
        }
        else {
            cell.categoryRightIcon.image = UIImage(named: icons[indexPath.row])
        }
        
        cell.layer.borderColor = #colorLiteral(red: 0.200000003, green: 0.200000003, blue: 0.200000003, alpha: 1).cgColor
        cell.layer.borderWidth = 0.5
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2
        
        return CGSize(width: width, height: (width / 4) * 3)
    }
    

}
