//
//  AchievementDetailsViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class AchievementDetailsViewController: UIViewController {

    @IBOutlet weak var achievementTitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var earnDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
    }

    override func willMove(toParentViewController parent: UIViewController?) {
        tabBarController?.tabBar.isHidden = false
    }
}
