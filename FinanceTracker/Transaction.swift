//
//  Transaction.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 09/06/2022.
//

import Foundation

class Transaction: Identifiable, ObservableObject, Codable {
	var id = UUID()
	@Published var label: String
	let amount: Float
	let currency: Currency
	let date: Date
	
	enum CodingKeys: CodingKey {
		case id
		case label
		case amount
		case currency
		case date
	}
	
	init(label: String, amount: Float, currency: Currency, date: Date) {
		self.label = label
		self.amount = amount
		self.currency = currency
		self.date = date
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(UUID.self, forKey: .id)
		self.label = try container.decode(String.self, forKey: .label)
		self.amount = try container.decode(Float.self, forKey: .amount)
		self.currency = try container.decode(Currency.self, forKey: .currency)
		self.date = try container.decode(Date.self, forKey: .date)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(label, forKey: .label)
		try container.encode(amount, forKey: .amount)
		try container.encode(currency.rawValue, forKey: .currency)
		try container.encode(date, forKey: .date)
	}
}
