//
//  Date+Extension.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/11/2022.
//

import Foundation

extension Date {
	var localizedMonth: String {
		let names = Calendar.current.monthSymbols
		let month = Calendar.current.component(.month, from: self)
		return names[month - 1]
	}
}
