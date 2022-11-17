//
//  Account.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 28/05/2022.
//

import Foundation

class Account: Identifiable, ObservableObject, Codable {
	
	var id = UUID()
	let icon: Icon
	@Published var name: String
	@Published var initialAmount: Float
	@Published var transactions: [Transaction]
	@Published var isFavourite: Bool
	var amount: Float {
		initialAmount + transactions.map { $0.amount }.reduce(0, +)
	}
	let currency: Currency
	
	enum CodingKeys: CodingKey {
		case id
		case name
		case icon
		case initialAmount
		case currency
		case transactions
		case isFavourite
	}
	
	init(icon: Icon, name: String, initialAmount: Float, transactions: [Transaction], currency: Currency, isFavourite: Bool = false) {
		self.icon = icon
		self.name = name
		self.initialAmount = initialAmount
		self.transactions = transactions
		self.currency = currency
		self.isFavourite = isFavourite
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(UUID.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.icon = try container.decode(Icon.self, forKey: .icon)
		self.initialAmount = try container.decode(Float.self, forKey: .initialAmount)
		self.currency = try container.decode(Currency.self, forKey: .currency)
		self.transactions = try container.decode([Transaction].self, forKey: .transactions)
		self.isFavourite = try container.decode(Bool.self, forKey: .isFavourite)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(icon, forKey: .icon)
		try container.encode(initialAmount, forKey: .initialAmount)
		try container.encode(currency.rawValue, forKey: .currency)
		try container.encode(transactions, forKey: .transactions)
		try container.encode(isFavourite, forKey: .isFavourite)
	}
}
