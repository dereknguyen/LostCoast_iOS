//
//  Step5ViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/20/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class Step5ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var tosTextView: UITextView!
    
    @IBAction func agreeToTOS(_ sender: UIButton) {
        guard let image = UIImage(data: Offline.currentUser.image!) else { return }
        
        ProgressHUD.shared.show(in: self.view, title: "Getting things ready", animated: true)
        LostCoastUserAPI.shared.uploadImage(image: image) { [weak self] (downloadURL, error) in
            
            guard let this = self else { return }
            guard let url = downloadURL else { return }
            
            if let err = error {
                
                DispatchQueue.main.async {
                    ProgressHUD.shared.dismiss(animated: true)
                }
                
                Alert.showAlert(in: this, title: "Upload Image Error", message: err.localizedDescription, handler: nil)
                return
            }
            
            Offline.currentUser.imageURL = url
            
            LostCoastUserAPI.shared.uploadProfile(profile: Offline.currentUser, completion: { (error) in
                
                DispatchQueue.main.async {
                    ProgressHUD.shared.dismiss(animated: true)
                }
                
                if let err = error {
                    Alert.showAlert(in: this, title: "Create Profile Error", message: err.localizedDescription, handler: nil)
                    return
                }
                else {
                    
                    RealmServiceAPI.shared.create(Offline.currentUser)
                    
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(true, forKey: WindowSwitcher.isSignedIn)
                        WindowSwitcher.updateRootViewController()
                    }
                }
            })
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tosTextView.delegate = self
        agreeButton.isEnabled = false
    }
}


extension Step5ViewController: UITextViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
            agreeButton.isEnabled = true
            agreeButton.alpha = 1.0
            agreeButton.setTitle("A G R E E", for: .normal)
        }
        else {
            agreeButton.isEnabled = false
            agreeButton.alpha = 0.2
            agreeButton.setTitle("Scroll Down to Bottom", for: .normal)
        }
    }
}
