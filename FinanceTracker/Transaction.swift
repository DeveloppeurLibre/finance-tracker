//
//  Transaction.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 09/06/2022.
//

import Foundation

struct Transaction {
	let label: String
	let amount: Float
	let currency: Currency
	let date: Date
}
