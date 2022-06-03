//
//  Account.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 28/05/2022.
//

import Foundation

struct Account: Identifiable {
	let id = UUID()
	let iconName: String
	let name: String
	let amount: Float
}
