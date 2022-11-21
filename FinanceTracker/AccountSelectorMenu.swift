//
//  AccountSelectorMenu.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 18/06/2022.
//

import SwiftUI

struct AccountSelectorMenu: View {
	
	let accountsList: AccountsList
	@Binding var selectedAccountIndex: Int
	let onCreateAccountButtonPressed: () -> Void
	@State private var isShowingAccountsList = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			HStack {
				HStack {
					Text(accountsList.accounts[selectedAccountIndex].name)
						.foregroundColor(.mainText)
                    Text("(\(accountsList.accounts[selectedAccountIndex].amount.localizedString) \(accountsList.accounts[selectedAccountIndex].currency.rawValue))")
						.foregroundColor(.secondaryText)
				}
				.padding(12)
				.padding(.horizontal, 12)
				Spacer()
				Button {
					withAnimation {
						isShowingAccountsList.toggle()
					}
				} label: {
					Image(systemName: isShowingAccountsList ? "multiply.circle" : "ellipsis.circle.fill")
						.font(.system(size: 32))
						.foregroundColor(Color("purple"))
						.padding(4)
				}
			}
			if isShowingAccountsList {
				ForEach(accountsList.accounts) { account in
					if accountsList.accounts[selectedAccountIndex].id != account.id {
						Divider()
						HStack {
							Text(account.name)
								.foregroundColor(.mainText)
                            Text("(\(account.amount.localizedString) \(account.currency.rawValue))")
								.foregroundColor(.secondaryText)
						}
						.padding(12)
						.padding(.horizontal, 12)
						.onTapGesture {
							withAnimation {
								selectedAccountIndex = accountsList.accounts.firstIndex { $0.id == account.id }!
								isShowingAccountsList = false
							}
						}
					}
				}
				Divider()
				Button {
					onCreateAccountButtonPressed()
				} label: {
					Text("Créer un compte")
						.foregroundColor(Color("purple"))
						.padding(12)
						.padding(.horizontal, 12)
				}
			}
		}
		.background(Color.textfieldBackground)
		.cornerRadius(22)
	}
}

struct AccountSelectorMenu_Previews: PreviewProvider {
    static var previews: some View {
		AccountSelectorMenu(
			accountsList: AccountsList(accounts: previewAccounts),
			selectedAccountIndex: .constant(0),
			onCreateAccountButtonPressed: {}
		)
		.padding()
		.background(Color.appBackground)
    }
}
