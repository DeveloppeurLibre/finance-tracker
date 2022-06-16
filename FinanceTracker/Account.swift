//
//  Account.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 28/05/2022.
//

import Foundation

class Account: Identifiable, ObservableObject {
	
	let id = UUID()
	let iconName: String
	let name: String
	let initialAmount: Float
	let transactions: [Transaction]
	var amount: Float {
		initialAmount + transactions.map { $0.amount }.reduce(0, +)
	}
	let currency: Currency
	
	init(iconName: String, name: String, initialAmount: Float, transactions: [Transaction], currency: Currency) {
		self.iconName = iconName
		self.name = name
		self.initialAmount = initialAmount
		self.transactions = transactions
		self.currency = currency
	}
}
