//
//  AirTableRepository.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import SwiftUI

struct RestRecords: Codable {
	let records: [RestFields]
}

struct RestFields: Codable {
	let fields: RestFeedback
}

struct RestFeedback: Codable {
	let appVersion: String?
	let buildVersion: String?
	let message: String
	
	enum CodingKeys: String, CodingKey {
		case appVersion = "App version"
		case buildVersion = "Build version"
		case message = "Message"
	}
}

class AirTableRepository {
	
	func postFeedback(message: String, completion: () -> Void) {
		let url = URL(string: "https://api.airtable.com/v0/apppnFiReEhXRXwEV/Feedback")!
		var request = URLRequest(url: url)
		
		request.setValue(
			"Bearer \(API_KEY)",
			forHTTPHeaderField: "Authorization"
		)

		request.setValue(
			"application/json",
			forHTTPHeaderField: "Content-Type"
		)
		
		let body = RestFields(fields: RestFeedback(
			appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
			buildVersion: Bundle.main.infoDictionary?["CFBundleVersion"] as? String,
			message: message)
		)
		
		let bodyData = try? JSONEncoder().encode(body)
		
		request.httpMethod = "POST"
		request.httpBody = bodyData
		
		let session = URLSession.shared
		let task = session.dataTask(with: request) { (data, response, error) in

			if let error = error {
				print("HTTP request error")
			} else if let data = data {
				print("HTTP request response")
			} else {
				print("unexpected error")
			}
		}
		task.resume()
		completion()
	}
}
