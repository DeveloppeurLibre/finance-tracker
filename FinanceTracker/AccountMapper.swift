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
            icon = .native(iconName: iconName)
        } else if let data = restAccount.importedIconData?.data(using: .utf8) {
            icon = .imported(data: data)
        } else {
            
            icon = .native(iconName: "")
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
        switch account.icon {
        case .imported(let data):
            return RestAccount(
                id: account.id,
                iconName: nil,
                importedIconData: String(decoding: data, as: UTF8.self),
                name: account.name,
                initialAmount: account.initialAmount,
                currency: account.currency,
                transactions: account.transactions,
                isFavourite: account.isFavourite
            )
        case .native(let name):
            return RestAccount(
                id: account.id,
                iconName: name,
                importedIconData: nil,
                name: account.name,
                initialAmount: account.initialAmount,
                currency: account.currency,
                transactions: account.transactions,
                isFavourite: account.isFavourite
            )
        }
    }
}
