//
//  NewTransactionView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 21/06/2022.
//

import SwiftUI

struct NewTransactionView: View {
	
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var accountsList: AccountsList
	let selectedAccountId: UUID?
	@FocusState var isAmountTextFieldFocused: Bool
	@State private var isPresentingNewAccountScreen = false
	@State private var selectedAccountIndex = 0
	@State private var textFieldAmount = ""
	@State private var transactionName = ""
	@State private var transactionDate = Date()
	@State private var amountIsNegative = false
	
	var body: some View {
		VStack(spacing: 32) {
			Text("Nouvelle transaction")
				.foregroundColor(.mainText)
				.font(.system(size: 32, weight: .bold))
				.padding(.top, 32)
			HStack {
				Text("-")
					.font(.system(size: 48, weight: .semibold))
					.foregroundColor(Color.secondaryText)
					.opacity(amountIsNegative ? 1 : 0)
                TextField(Float.zero.localizedString, text: $textFieldAmount)
					.keyboardType(.decimalPad)
					.font(.system(size: 48, weight: .semibold))
					.foregroundColor(Color.secondaryText)
					.frame(width: nil, height: nil, alignment: .trailing)
					.focused($isAmountTextFieldFocused)
				Text(accountsList.accounts[selectedAccountIndex].currency.rawValue)
					.foregroundColor(.mainText)
					.font(.system(size: 24, weight: .light))
			}
			.multilineTextAlignment(.center)
			VStack(spacing: 16) {
				AccountSelectorMenu(accountsList: accountsList, selectedAccountIndex: $selectedAccountIndex, onCreateAccountButtonPressed: {
					// à completer plus tard
					isPresentingNewAccountScreen = true
				})
				TextField("Ex : Loyer...", text: $transactionName)
					.submitLabel(.done)
					.padding(12)
					.padding(.horizontal, 12)
					.background(Color.textfieldBackground)
					.cornerRadius(.infinity)
				DatePicker("Date :", selection: $transactionDate)
					.padding(.leading, 24)
					.padding(.trailing, 8)
			}
			Spacer()
			MainButton(title: "Ajouter") {
				let newTransaction = Transaction(
					label: transactionName,
                    amount: textFieldAmount.floatValue * (amountIsNegative ? -1 : 1),
					currency: accountsList.accounts[selectedAccountIndex].currency,
					date: transactionDate
				)
				accountsList.accounts[selectedAccountIndex].transactions.append(newTransaction)
				presentationMode.wrappedValue.dismiss()
			}
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color.appBackground)
		.ignoresSafeArea(.keyboard)
		.sheet(isPresented: $isPresentingNewAccountScreen) {
			AccountCreationView { newAccount in
				accountsList.accounts.append(newAccount)
			}
		}
		.onAppear {
			if let selectedAccountId {
				let index = accountsList.accounts.firstIndex { account in
					account.id == selectedAccountId
				} ?? 0
				self.selectedAccountIndex = index
			}
		}
		.overlay {
			if isAmountTextFieldFocused {
				VStack(spacing: 0) {
					Spacer()
					Divider()
					AmountKeyboardToolbar {
						isAmountTextFieldFocused = false
					} onNegativePressed: {
						amountIsNegative = true
					} onPositivePressed: {
						amountIsNegative = false
					}

				}
				.opacity(isAmountTextFieldFocused ? 1 : 0)
				.animation(.easeOut(duration: 0.2), value: isAmountTextFieldFocused)
			}
		}
	}
}

struct NewTransactionView_Previews: PreviewProvider {
	static var previews: some View {
		NewTransactionView(selectedAccountId: previewAccounts.first!.id)
			.environmentObject(AccountsList(accounts: previewAccounts))
	}
}
