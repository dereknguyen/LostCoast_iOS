//
//  ChartsExtensions.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/27/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Charts

extension LineChartView {
    
    func buildPreview() {
        self.chartDescription?.enabled = false
        self.dragEnabled = false
        self.dragXEnabled = false
        self.dragYEnabled = false
        self.pinchZoomEnabled = false
        self.highlightPerTapEnabled = true
        self.doubleTapToZoomEnabled = false
        self.dragDecelerationEnabled = false
   
        self.autoScaleMinMaxEnabled = false
        self.scaleXEnabled = false
        self.scaleYEnabled = false
        self.clipDataToContentEnabled = false
        
        self.legend.form = .none
        self.legend.enabled = false
        
        
        self.leftAxis.enabled = true
        self.leftAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.leftAxis.axisLineColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.leftAxis.gridColor = #colorLiteral(red: 0.1000000015, green: 0.1000000015, blue: 0.1000000015, alpha: 1)
        self.leftAxis.labelFont = .systemFont(ofSize: 9, weight: .heavy)
        
        self.rightAxis.enabled = false
        self.leftAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.leftAxis.axisLineColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.leftAxis.labelFont = .systemFont(ofSize: 9, weight: .heavy)
        
        self.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.xAxis.axisLineColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.xAxis.gridColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.xAxis.spaceMin = 1
        self.xAxis.spaceMax = 1
        self.xAxis.valueFormatter = XAxisValueFormatter()
        self.xAxis.labelPosition = .bottom
        self.xAxis.labelFont = .systemFont(ofSize: 9, weight: .heavy)
        self.xAxis.avoidFirstLastClippingEnabled = true
        
    }
}

extension LineChartDataSet {
    
    func buildPreview(colorTheme: UIColor) {
        
        let gradient = CGGradient(
            colorsSpace: nil,
            colors: [#colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1).cgColor, colorTheme.cgColor] as CFArray,
            locations: nil
        )!

        self.fill = Fill(
            linearGradient: gradient,
            angle: 90
        )
        self.fillAlpha = 0.2
        self.setColor(colorTheme)
        self.setCircleColor(colorTheme)
        self.valueTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        self.drawCirclesEnabled = true
        self.drawCircleHoleEnabled = false
        self.drawIconsEnabled = false
        self.drawVerticalHighlightIndicatorEnabled = false
        self.drawHorizontalHighlightIndicatorEnabled = true
        self.drawValuesEnabled = false
        self.drawFilledEnabled = true
        
        
        self.lineWidth = 1.5
        self.circleRadius = 3
        self.valueFont = UIFont.systemFont(ofSize: 9, weight: .black)
    }
}







