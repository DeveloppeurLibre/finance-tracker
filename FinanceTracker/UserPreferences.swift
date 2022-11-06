//
//  UserPreferences.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import Foundation

class UserPreferences: ObservableObject, Codable {
	@Published var showFeedbackButton: Bool
	@Published var hasReadFeedbackButtonAlertMessage: Bool
	
	init() {
		self.showFeedbackButton = true
		self.hasReadFeedbackButtonAlertMessage = false
	}
	
	enum CodingKeys: CodingKey {
		case showFeedbackButton
		case hasReadFeedbackButtonAlertMessage
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.showFeedbackButton = try container.decode(Bool.self, forKey: .showFeedbackButton)
		self.hasReadFeedbackButtonAlertMessage = try container.decode(Bool.self, forKey: .hasReadFeedbackButtonAlertMessage)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(showFeedbackButton, forKey: .showFeedbackButton)
		try container.encode(hasReadFeedbackButtonAlertMessage, forKey: .hasReadFeedbackButtonAlertMessage)
	}
}
