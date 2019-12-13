//
//  SegmentControlBuilder.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/27/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Segmentio

class SegmentControlBuilder {
    
    static func buildSegmentControl(segmentView: Segmentio, content: [SegmentioItem], style: SegmentioStyle, position: SegmentioPosition = .fixed(maxVisibleItems: 3)) {
        segmentView.selectedSegmentioIndex = 0
        segmentView.setup(content: content,
                          style: style,
                          options: options(style: style, position: position))
    }
    
    private static func options(style: SegmentioStyle, position: SegmentioPosition) -> SegmentioOptions {
        return SegmentioOptions(backgroundColor: UIColor.clear,
                                segmentPosition: position,
                                scrollEnabled: false,
                                indicatorOptions: indicatorOptions(),
                                horizontalSeparatorOptions: horizontalSeparatorOptions(),
                                verticalSeparatorOptions: verticalSeparatorOptions(),
                                imageContentMode: UIViewContentMode.center,
                                labelTextAlignment: .center,
                                labelTextNumberOfLines: 1,
                                segmentStates: states(),
                                animationDuration: 0.05)
    }
    
    private static func indicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(type: .bottom,
                                         ratio: 1,
                                         height: 3,
                                         color: #colorLiteral(red: 0.1083171442, green: 0.8400114775, blue: 0.8413270116, alpha: 1))
    }
    
    private static func horizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(type: .none,
                                                   height: 0,
                                                   color: .clear)
    }
    
    private static func verticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(ratio: 1, color: .clear)
    }
    
    private static func state(titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(backgroundColor: .clear,
                              titleFont: UIFont.systemFont(ofSize: 15, weight: .bold),
                              titleTextColor: titleTextColor)
    }
    
    private static func states() -> SegmentioStates {
        return SegmentioStates(
            defaultState: state(titleTextColor: #colorLiteral(red: 0.3977887332, green: 0.3977887332, blue: 0.3977887332, alpha: 1)),
            selectedState: state(titleTextColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
            highlightedState: state(titleTextColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        )
    }
}
