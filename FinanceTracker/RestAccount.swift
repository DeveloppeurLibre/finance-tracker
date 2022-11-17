//
//  RestAccount.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 08/11/2022.
//

import Foundation

struct RestAccount: Codable {
	let id: UUID
	let iconName: String?
	let importedIconFileName: String?
	let name: String
	let initialAmount: Float
	let currency: Currency
	let transactions: [Transaction]
	let isFavourite: Bool
}
