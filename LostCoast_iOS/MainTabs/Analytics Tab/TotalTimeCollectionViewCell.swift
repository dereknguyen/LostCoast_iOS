//
//  TotalTimeCollectionViewCell.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/28/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Charts

class TotalTimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var calculationType: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupChartView()
    }

}

extension TotalTimeCollectionViewCell: ChartViewDelegate {
    
    private func setupChartView() {
        chartView.delegate = self
        chartView.buildPreview()
        chartView.animate(yAxisDuration: 0.5)
        setChartData()
    }
    
    private func setChartData() {
        let values = (1...10).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(10))
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        set1.buildPreview(colorTheme: #colorLiteral(red: 0.137254902, green: 0.8117647059, blue: 0.8039215686, alpha: 1))
        let data = LineChartData(dataSet: set1)
        
        chartView.data = data
    }
}
