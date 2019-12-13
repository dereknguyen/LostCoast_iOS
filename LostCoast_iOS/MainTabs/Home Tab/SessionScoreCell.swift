//
//  SessionScoreCell.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/26/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Charts

class SessionScoreCell: UITableViewCell, ChartViewDelegate {

    private let categories = ["Power", "Flow", "Speed", "Variety", "Difficulty"]
    var scores = [Int]()
    
    @IBOutlet weak var overallScoreChartView: RadarChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupScoreChartView_UI()
//        layoutSubviews()
    }

    private func setupScoreChartView_UI() {
        self.overallScoreChartView.delegate = self
        self.overallScoreChartView.rotationEnabled = false
        self.overallScoreChartView.chartDescription?.enabled = false
        self.overallScoreChartView.webLineWidth = 1
        self.overallScoreChartView.innerWebLineWidth = 1
        self.overallScoreChartView.skipWebLineCount = 0
        self.overallScoreChartView.webColor = #colorLiteral(red: 0.3179988265, green: 0.3179988265, blue: 0.3179988265, alpha: 1)
        self.overallScoreChartView.innerWebColor = #colorLiteral(red: 0.3179988265, green: 0.3179988265, blue: 0.3179988265, alpha: 1)
        self.overallScoreChartView.webAlpha = 1.0
        
        let xAxis = overallScoreChartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .white
        
        let yAxis = overallScoreChartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 9
        yAxis.drawLabelsEnabled = true
        yAxis.labelTextColor = .white
        
        let l = overallScoreChartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = true
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xEntrySpace = 20
        l.textColor = .white
        
        setChartData()
//        self.overallScoreChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeOutQuart)
    }
    
    private func setChartData() {
        
//        // RNG DATA
//        let mult: UInt32 = 10
//        let min: UInt32 = 0
//        let cnt = 5
//
//        let block: (Int) -> RadarChartDataEntry = {
//            _ in
//            return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))
//        }
        
//        let entries1 = (0..<cnt).map(block)
//        let entries2 = (0..<cnt).map(block)
        var entries3 = [RadarChartDataEntry]()
        if scores.count > 0 {
        
            entries3 = [
                RadarChartDataEntry(value: Double(scores[0])),
                RadarChartDataEntry(value: Double(scores[1])),
                RadarChartDataEntry(value: Double(scores[2])),
                RadarChartDataEntry(value: Double(scores[3])),
                RadarChartDataEntry(value: Double(scores[4]))
            ]
        }
  
        
//        // SET DATA TO CHART
//        let set1 = RadarChartDataSet(values: entries1, label: "Your Potential")
//        set1.setColor(#colorLiteral(red: 0.7523762584, green: 0.7523762584, blue: 0.7523762584, alpha: 0.5))
//        set1.fillColor = #colorLiteral(red: 0.7523762584, green: 0.7523762584, blue: 0.7523762584, alpha: 0.5)
//        set1.drawFilledEnabled = true
//        set1.fillAlpha = 0.75
//        set1.lineWidth = 1
//        set1.drawHighlightCircleEnabled = true
//        set1.setDrawHighlightIndicators(false)
        
        let set2 = RadarChartDataSet(values: entries3, label: "Current Session")
        set2.setColor(#colorLiteral(red: 0.137254902, green: 0.8117647059, blue: 0.8039215686, alpha: 1))
        set2.fillColor = #colorLiteral(red: 0.137254902, green: 0.8117647059, blue: 0.8039215686, alpha: 0.75)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.95
        set2.lineWidth = 1
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        
        let data = RadarChartData(dataSets: [set2])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(false)
        data.setValueTextColor(.white)
        
        self.overallScoreChartView.data = data
        
    }
}

extension SessionScoreCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return categories[Int(value) % categories.count]
    }
}
