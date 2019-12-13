//
//  SearchBarExtension.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/23/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

extension UISearchBar {
    func setSearchField(color: UIColor) {
        let textField = self.value(forKey: "searchField") as? UITextField
        textField?.textColor = color
    }
}
