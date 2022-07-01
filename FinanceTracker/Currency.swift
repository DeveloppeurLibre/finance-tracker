//
//  Currency.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 04/06/2022.
//

import Foundation

enum Currency: String, CaseIterable, Codable {
	case dollar = "$"
	case euro = "€"
	case ruble = "₽"
	case sterling = "£"
	case yen = "¥"
	
	var iconName: String {
		switch self {
			case .dollar:
				return "dollarsign.circle"
			case .euro:
				return "eurosign.circle"
			case .ruble:
				return "rublesign.circle"
			case .sterling:
				return "sterlingsign.circle"
			case .yen:
				return "yensign.circle"
		}
	}
	
	var filledIconName: String {
		return "\(iconName).fill"
	}
}
