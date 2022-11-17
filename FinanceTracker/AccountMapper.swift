//
//  AccountMapper.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 08/11/2022.
//

import Foundation
import SwiftUI

extension URL {
    func loadData() -> Data? {
        try? Data(contentsOf: self)
    }
    func saveData(_ data: Data?) {
        if let data {
            try? data.write(to: self)
        } else {
            try? FileManager.default.removeItem(at: self)
        }
    }
}

class AccountMapper {
    
    static func map(restAccount: RestAccount) -> Account {
        
        let icon: Icon
        
        if let iconName = restAccount.iconName {
            icon = .native(iconName: iconName)
        } else if let fileName = restAccount.importedIconFileName {
            icon = .imported(fileName: fileName)
        } else {
            icon = .native(iconName: "") // Replace by placeholder
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
        case .imported(let fileName):
            
            return RestAccount(
                id: account.id,
                iconName: nil,
                importedIconFileName: fileName,
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
                importedIconFileName: nil,
                name: account.name,
                initialAmount: account.initialAmount,
                currency: account.currency,
                transactions: account.transactions,
                isFavourite: account.isFavourite
            )
        }
    }
}
