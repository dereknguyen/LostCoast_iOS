//
//  RefreshView.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/25/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class RefreshView: UIView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var gradientView: UIView!
}

extension RefreshView {
    
    fileprivate func initGradientView() {
        gradientView = UIView(frame: CGRect(x: -30, y: 0, width: 100, height: 26))
        logoImageView.addSubview(gradientView)
        gradientView.layer.insertSublayer(gradientColor(frame: gradientView.bounds), at: 0)
        gradientView.backgroundColor = .clear
    }
    
    fileprivate func gradientColor(frame: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.5)
        layer.endPoint = CGPoint(x: 0, y: 0.5)
        layer.colors = [
            #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1).withAlphaComponent(0).cgColor,
            #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1).withAlphaComponent(0.4).cgColor,
            #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1).withAlphaComponent(0).cgColor,
        ]
        
        
        return layer
    }
    
    func startAnimation() {
        initGradientView()
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            self.gradientView.frame.origin.x = 100
        }, completion: nil)
    }
    
    func stopAnimation() {
        gradientView.layer.removeAllAnimations()
        gradientView = nil
    }
    
}
