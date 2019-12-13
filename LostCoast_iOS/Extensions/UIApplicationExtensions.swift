//
//  UIApplicationExtensions.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/22/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
