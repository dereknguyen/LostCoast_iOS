//
//  XAxisValueFormatter.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 9/14/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation
import Charts
class XAxisValueFormatter: NSObject, IAxisValueFormatter {
    
    let numFormatter: NumberFormatter
    
    override init() {
        numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 1
        numFormatter.maximumFractionDigits = 1
        
        // if number is less than 1 add 0 before decimal
        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .beforePrefix
        numFormatter.paddingCharacter = "0"
    }
    
    /// Called when a value from an axis is formatted before being drawn.
    ///
    /// For performance reasons, avoid excessive calculations and memory allocations inside this method.
    ///
    /// - returns: The customized label that is drawn on the axis.
    /// - parameter value:           the value that is currently being drawn
    /// - parameter axis:            the axis that the value belongs to
    ///
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}
