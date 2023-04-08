//
//  Double.swift
//  Distance
//
//  Created by Aaron Wilson on 4/7/23.
//

import Foundation

extension Double {
    
    private var distanceFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    func asDistanceWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return distanceFormatter2.string(from: number) ?? "0.00"
    }
}
