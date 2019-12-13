//
//  Step2ViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/16/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Photos

class Step2ViewController: UIViewController {
    
    private var imagePickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        return pickerController
    }()
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var imageSelectButton: UIButton!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!

    @IBAction func selectProfileImage(_ sender: UIButton) {
      
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            present(self.imagePickerController, animated: true, completion: nil)
        case .denied, .restricted:
            Alert.showPhotoPrivacyAlert(in: self)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {
                [weak self] (status) in
                guard let this = self else { return }
                switch status {
                case .authorized:
                    this.present(this.imagePickerController, animated: true, completion: nil)
                case .denied, .restricted:
                    Alert.showPhotoPrivacyAlert(in: this)
                case .notDetermined:
                    break;
                }
            }
        }
    }
    
    @IBAction func continueToStep3(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Step2ToStep3", sender: nil)
    }
    
    @IBAction func unwindToStep2(_ sender: UIStoryboardSegue) { }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController.delegate = self
        
        setup_UI()
    }
}

extension Step2ViewController {
    
    private func setup_UI() {
        
        if let imageData = Offline.currentUser.image {
            profileImageView.image = UIImage(data: imageData)
        }
        else {
            guard let image = profileImageView.image else { return }
            let imageData = UIImageJPEGRepresentation(image, 0.7)
            Offline.currentUser.image = imageData
        }
        
        fullNameLabel.text = "\(Offline.currentUser.firstName) \(Offline.currentUser.lastName)"
        usernameLabel.text = "\(Offline.currentUser.username)"
    }
}

// MARK: - Image Picker Controller Extensions
extension Step2ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            let imageData = UIImageJPEGRepresentation(editedImage, 0.3)
            Offline.currentUser.image = imageData
            profileImageView.image = UIImage(data: imageData!)
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let imageData = UIImageJPEGRepresentation(originalImage, 0.3)
            Offline.currentUser.image = imageData
            profileImageView.image = UIImage(data: imageData!)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
