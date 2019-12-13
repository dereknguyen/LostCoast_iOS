//
//  Step3ViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/20/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import UserNotifications

class Step3ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBAction func presentNotificationPrivacyPrompt(_ sender: UIButton) {
        
        UNUserNotificationCenter.current().getNotificationSettings {
            [weak self] (settings) in
            
            guard let this = self else { return }
            
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    this.performSegue(withIdentifier: "Step3ToStep4", sender: this)
                }
            }
            else if settings.authorizationStatus == .denied {
                Alert.showAlert(in: this, title: "Notifcation Permission Denied", message: "You can change this later in the setting app.") {
                    _ in
                    
                    DispatchQueue.main.async {
                        this.performSegue(withIdentifier: "Step3ToStep4", sender: this)
                    }
                }
            }
            else if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                    (granted, error) in
            
                    if granted {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func skip(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Step3ToStep4", sender: self)
    }
    
    @IBAction func unwindToStep3(_ sender: UIStoryboardSegue) { }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

