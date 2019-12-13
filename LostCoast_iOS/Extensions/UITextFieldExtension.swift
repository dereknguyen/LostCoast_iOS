//
//  UITextFieldExtension.swift
//  LostCoastSurfTech
//
//  Created by Derek Nguyen on 7/3/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// If textfield represent email, this will check if email is valid using RFC 5322 Reg Ex.
    /// - parameter 'printTo errorLabel': Label to display error message to
    /// - returns: Validity of email address.
    func verifyEmailTextField(printTo errorLabel: UILabel) -> Bool {
        if let email = self.text, email.isEmailValid() {
            errorLabel.text = ""
            return true
        }
        else {
            errorLabel.text = "Email Invalid"
            return false
        }
    }
    
    /// Verify if password is at least 6 characters count.
    /// - parameter 'printTo errorLabel': Label to display error message to
    /// - returns: Validity of password
    func verifyCharacterCount(printTo errorLabel: UILabel) -> Bool {
        guard let text = self.text else { return false }
        
        if text.count >= 6 {
            errorLabel.text = ""
            return true
        }
        else {
            errorLabel.text = "Password must be at least 6 characters long."
            return false
        }
    }
    
    func getText(from viewController: UIViewController, type: TextFieldType, process: ProcessErrorType) -> String? {
        if let text = self.text, text.count > 0 {
            return text
        }
        else {
            Alert.showAlert(in: viewController, title: "\(process.rawValue) Error", message: "\(type.rawValue) is empty.", handler: nil)
            return nil
        }
    }
    
}
