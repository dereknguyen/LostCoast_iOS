//
//  WavesCaughtCollectionViewCell.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/28/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

class WavesCaughtCollectionViewCell: UICollectionViewCell {

    var wavesCaught = 0
    
    @IBOutlet weak var totalWavesCaught: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        totalWavesCaught.text = String(wavesCaught)
    }

}
