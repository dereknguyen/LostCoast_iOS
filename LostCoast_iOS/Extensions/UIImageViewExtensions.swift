//
//  UIImageViewExtensions.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/15/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func addGradient(start startPoint: CGPoint, end endPoint: CGPoint, colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        
        self.layer.addSublayer(gradientLayer)
    }
}
