//
//  AccountMapper.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 08/11/2022.
//

import Foundation

class AccountMapper {
	static func map(restAccount: RestAccount) -> Account {
		
		let icon: Icon
		
		if let iconName = restAccount.iconName {
			icon = .native(iconName)
		} else if let data = restAccount.importedIconData {
			icon = .imported(data)
		} else {
			fatalError("No icon provided")
		}
		
		return Account(
			icon: icon,
			name: restAccount.name,
			initialAmount: restAccount.initialAmount,
			transactions: restAccount.transactions,
			currency: restAccount.currency
		)
	}
	
	static func map(account: Account) -> RestAccount {
		var iconName: String? = nil
		var importedIconData: Data? = nil
		switch account.icon {
			case .imported(let data):
				importedIconData = data
			case .native(let name):
				iconName = name
		}
		
		return RestAccount(
			id: account.id,
			iconName: iconName,
			importedIconData: importedIconData,
			name: account.name,
			initialAmount: account.initialAmount,
			currency: account.currency,
			transactions: account.transactions,
			isFavourite: account.isFavourite
		)
	}
}
