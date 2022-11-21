//
//  String+Extension.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 21/11/2022.
//

import Foundation

extension String {
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    
    var floatValue: Float {
        let string = self.replacingOccurrences(of: formatter.decimalSeparator, with: ".")
        return Float(string) ?? 0.0
    }
}
