//
//  WindowSwitcher.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 9/3/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class WindowSwitcher {
    
    static let isSignedIn = "isSignedIn"
    
    static func updateRootViewController() {
        
        let authStatus = UserDefaults.standard.bool(forKey: isSignedIn)
        var rootVC: UIViewController?
        
        if authStatus {
            let storyboard = UIStoryboard(name: "MainTabs", bundle: nil)
            rootVC = storyboard.instantiateViewController(withIdentifier: "MainTabs") as! MainTabBarController
        }
        else {
            let storyboard = UIStoryboard(name: "LoginAndSignup", bundle: nil)
            rootVC = storyboard.instantiateViewController(withIdentifier: "GreetingViewController") as! GreetingViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
