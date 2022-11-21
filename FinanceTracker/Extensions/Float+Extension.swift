//
//  Float+Extension.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 21/11/2022.
//

import Foundation

extension Float {
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var localizedString: String {
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
    
}
