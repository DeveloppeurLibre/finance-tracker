//
//  AccountList.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 08/06/2022.
//

import Foundation

class AccountsList: ObservableObject {
	
	@Published var accounts: [Account]
	
	init(accounts: [Account] = []) {
		self.accounts = accounts
	}
	
	static func save(accounts: [Account], completion: @escaping (Result<Int, Error>)->Void) {
		DispatchQueue.global(qos: .background).async {
			do {
				let data = try JSONEncoder().encode(accounts)
				let outfile = try fileURL()
				try data.write(to: outfile)
				DispatchQueue.main.async {
					completion(.success(accounts.count))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
		}
	}
	
	private static func fileURL() throws -> URL {
		let path = try FileManager.default.url(for: .documentDirectory,
									in: .userDomainMask,
									appropriateFor: nil,
									create: false)
		let url = path.appendingPathComponent("accounts.data")
		return url
	}
}
