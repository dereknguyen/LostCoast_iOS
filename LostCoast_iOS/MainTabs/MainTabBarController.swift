//
//  MainTabBarController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/22/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {

    private lazy var gradientLayer: CAGradientLayer = {
        var layer = CAGradientLayer()
        layer.colors = [#colorLiteral(red: 0.137254902, green: 0.8117647059, blue: 0.8039215686, alpha: 1).cgColor, #colorLiteral(red: 0.02352941176, green: 0.1568627451, blue: 0.2980392157, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        layer.frame = CGRect(x: 0, y: 0, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height + 50)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.layer.insertSublayer(gradientLayer, at: 0)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8999999762, green: 0.8999999762, blue: 0.8999999762, alpha: 1)
    
        if Auth.auth().currentUser != nil {
            let userResults = RealmServiceAPI.shared.realm.objects(LostCoastUser.self)
            Offline.currentUser = userResults[0]
        }
        
    }
}
