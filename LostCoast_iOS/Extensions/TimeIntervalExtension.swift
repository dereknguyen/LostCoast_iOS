//
//  TimeIntervalExtension.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 9/13/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation

extension TimeInterval {
    func getText() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM  /  dd  /  yyyy"
        return "\(dateFormatter.string(from: date))"
    }
}
