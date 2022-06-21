//
//  NewTransactionView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 21/06/2022.
//

import SwiftUI

struct NewTransactionView: View {
	
	let accountsList: AccountsList
	@State private var selectedAccountIndex = 0
	@State private var textFieldAmount = ""
	@State private var transactionName = ""

    var body: some View {
		VStack(spacing: 32) {
			Text("Nouvelle transaction")
				.font(.system(size: 32, weight: .bold))
				.padding(.top, 32)
			HStack {
				TextField("0.00", text: $textFieldAmount)
					.keyboardType(.numbersAndPunctuation)
					.submitLabel(.done)
					.font(.system(size: 48, weight: .semibold))
					.foregroundColor(Color.black.opacity(0.4))
					.frame(width: nil, height: nil, alignment: .trailing)
				Text(accountsList.accounts[selectedAccountIndex].currency.rawValue)
					.font(.system(size: 24, weight: .light))
			}
			.multilineTextAlignment(.center)
			VStack(spacing: 16) {
				AccountSelectorMenu(accountsList: accountsList, selectedAccountIndex: $selectedAccountIndex, onCreateAccountButtonPressed: {
					// à completer plus tard
				})
				TextField("Ex : Loyer...", text: $transactionName)
					.submitLabel(.done)
					.padding(12)
					.padding(.horizontal, 12)
					.background(Color.white)
					.cornerRadius(.infinity)
			}
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color("grey"))
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
		NewTransactionView(accountsList: AccountsList(accounts: previewAccounts))
    }
}
