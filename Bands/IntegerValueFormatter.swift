//
//  IntegerValueFormatter.swift
//  Bands
//
//  Created by Gabriel Araujo on 07/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation
import Charts

class IntegerValueFormatter : NSObject, IValueFormatter {
    
    override init() {
        super.init()
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(Int(value))"
    }
}
