//
//  Icon.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/11/2022.
//

import Foundation

enum Icon: Codable, Equatable {
	case imported(Data)
	case native(String)
}
