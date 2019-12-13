//
//  DesignableButton.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 9/1/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var firstStopColor: UIColor? {
        didSet {
            setGradient(firstStop: firstStopColor, secondStop: secondStopColor)
        }
    }
    
    @IBInspectable
    var secondStopColor: UIColor? {
        didSet {
            setGradient(firstStop: firstStopColor, secondStop: secondStopColor)
        }
    }
    
    private func setGradient(firstStop: UIColor?, secondStop: UIColor?) {
        if let first = firstStop, let second = secondStop {
            gradientLayer.frame = bounds
            gradientLayer.colors = [first.cgColor, second.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            layer.insertSublayer(gradientLayer, at: 0)
        }
        else {
            gradientLayer.removeFromSuperlayer()
        }
    }

}
