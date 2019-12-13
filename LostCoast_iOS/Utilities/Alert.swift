//
//  Alert.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/17/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class Alert {
    
    private init() {}
    
    static func showAlert(in viewController: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showAlertWithCancel(in viewController: UIViewController, title: String, message: String, actionTitle: String, style: UIAlertActionStyle = .default, action: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let assignedAction = UIAlertAction(title: actionTitle, style: style, handler: action)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(assignedAction)
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showPhotoPrivacyAlert(in viewController: UIViewController) {
        let alert = UIAlertController(title: "Photo Privacy",
                                      message: "This app is not authorized to access your photo library. You can change this in setting.",
                                      preferredStyle: .alert)
        
        let settingAction = UIAlertAction(title: "Setting", style: .default) { (_) in
            DispatchQueue.main.async {
                if let settingURL = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showPushNotificationAlert(in viewController: UIViewController) {
        let alert = UIAlertController(title: "Notification Privacy",
                                      message: "The app will not send you notification. You can change this in setting.",
                                      preferredStyle: .alert)
        
        let settingAction = UIAlertAction(title: "Setting", style: .default) { (_) in
            DispatchQueue.main.async {
                if let settingURL = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showSettingAlert(in viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cance;", style: .cancel, handler: nil)
        let settingAction = UIAlertAction(title: "Setting", style: .default) { (_) in
            DispatchQueue.main.async {
                if let settingURL = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(settingAction)
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
