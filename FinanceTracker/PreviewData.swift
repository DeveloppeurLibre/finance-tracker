//
//  PreviewData.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/05/2022.
//

import Foundation

let previewAccounts = [
	Account(iconName: "icon_002", name: "PayPal", amount: 289.56),
	Account(iconName: "icon_007", name: "Binance", amount: 3656.54),
	Account(iconName: "icon_001", name: "Bourso", amount: 2718.45)
]

let previewTransactions = [
	Transaction(label: "Repas du midi", amount: 8.54, currency: .euro, date: Date()),
	Transaction(label: "Tickets de métro", amount: 16.50, currency: .euro, date: Date()),
	Transaction(label: "Loyer", amount: 745, currency: .euro, date: Date())
]
