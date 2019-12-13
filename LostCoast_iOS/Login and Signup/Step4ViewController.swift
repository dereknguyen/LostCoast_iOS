//
//  Step4ViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/20/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import CoreLocation

class Step4ViewController: UIViewController {
    
    let locManager = CLLocationManager()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBAction func enableNotification(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locManager.requestWhenInUseAuthorization()
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Step4ToStep5", sender: self)
                }
            case .restricted, .denied:
                Alert.showAlert(in: self, title: "Notification Services are not enabled", message: "You can enable them in the setting app.", handler: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Step4ToStep5", sender: self)
                }
            }
        }
        else {
            Alert.showSettingAlert(in: self, title: "Notification Services are not enabled", message: "You can enable them in the setting app.")
        }
    }
    

    @IBAction func skip(_ sender: UIButton) {
        performSegue(withIdentifier: "Step4ToStep5", sender: self)
    }
    
    @IBAction func unwindToStep4(_ sender: UIStoryboardSegue) { }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

