//
//  ProgressHUD.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/19/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProgressHUD {
    
    private init() {}
    static var shared = ProgressHUD()
    
    private var hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: JGProgressHUDStyle.dark)
        hud.interactionType = .blockAllTouches
        hud.parallaxMode = .alwaysOff
        return hud
    }()
    
    func show(in view: UIView, title: String, animated: Bool) {
        ProgressHUD.shared.hud.textLabel.text = title
        ProgressHUD.shared.hud.show(in: view, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        ProgressHUD.shared.hud.dismiss(animated: animated)
    }
}
