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
}
