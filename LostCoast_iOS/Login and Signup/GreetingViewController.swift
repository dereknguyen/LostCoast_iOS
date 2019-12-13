//
//  ViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/15/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController {
    
    var isFirst = true
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: - Unwind Segues
    @IBAction func unwindToGreeting(_ sender: UIStoryboardSegue) { }
    @IBAction func unwindToGreetingFromSetup(_ sender: UIStoryboardSegue) { }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirst {
            isFirst = false

            UIView.animate(withDuration: 0.7, delay: 0.1, options: .curveEaseIn, animations: {
                self.backgroundImage.alpha = 1
            }) { _ in
                self.show(button: self.loginButton, delay: 0.4)
                self.show(button: self.signupButton, delay: 0.5)
            }
            //            }
        }
    }
    
    // MARK: - View's Life Cycle    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.alpha = 0
        
        hide(button: loginButton)
        hide(button: signupButton)
        
        navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarView?.backgroundColor = .clear
    }
}

// MARK: - UI Helper Methods
extension GreetingViewController {
    
    private func hide(button: UIButton) {
        let tY = UIScreen.main.bounds.height - button.frame.origin.y
        button.transform = CGAffineTransform(translationX: 0.0, y: tY)
    }
    
    private func show(button: UIButton, delay: TimeInterval) {
        UIView.animate(withDuration: 0.3, delay: delay, options: .curveEaseInOut, animations: {
            button.transform = .identity
        }, completion: nil)
    }
}



