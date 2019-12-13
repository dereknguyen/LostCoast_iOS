//
//  AnalysisHighlightCell.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/27/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Charts

class AnalysisHighlightCell: UICollectionViewCell {

    var resultToDisplay = [Double]()
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var statCalculationType: UILabel!
    @IBOutlet weak var statValue: UILabel!
    @IBOutlet weak var statUnit: UILabel!
    
    @IBOutlet weak var chartView: LineChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupChartView()
    }

}

extension AnalysisHighlightCell: ChartViewDelegate {
    
    private func setupChartView() {
        chartView.delegate = self
        chartView.buildPreview()
        chartView.animate(yAxisDuration: 0.5)
        setChartData()
    }
    
    private func setChartData() {
        
        var values = [ChartDataEntry]()
        
        for (index, value) in resultToDisplay.enumerated() {
            values.append(ChartDataEntry(x: Double(index), y: value))
        }
        
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        set1.buildPreview(colorTheme: #colorLiteral(red: 0.137254902, green: 0.8117647059, blue: 0.8039215686, alpha: 1))
        let data = LineChartData(dataSet: set1)
        
   
        
        chartView.data = data
    }
}

extension AnalysisHighlightCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value == 0.0 {
            return ""
        }
        else {
            return String(Int(value))
        }
    }
}
