//
//  AccountCreationView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 04/06/2022.
//

import SwiftUI

struct AccountCreationView: View {
	
	@Environment(\.presentationMode) var presentationMode
	
	@State private var accountName: String = ""
	@State private var amount: String = ""
	@State private var selectedIcon: String = "icon_001"
	@State private var selectedCurrency: Currency = .euro
	var onAccountCreated: (Account) -> Void
	
    var body: some View {
		NavigationView {
			VStack(spacing: 32) {
				VStack(spacing: 16) {
					Text(accountName == "" ? "Nouveau compte" : accountName)
						.font(.system(size: 32, weight: .bold))
						.padding(.top, 32)
					Text("Solde : \(String(format: "%.2f", Float(amount) ?? 0.0)) \(selectedCurrency.rawValue)")
						.font(.system(size: 20, weight: .light))
						.foregroundColor(Color.secondaryText)
						.frame(maxWidth: .infinity)
				}
				.frame(maxWidth: .infinity)
				VStack(alignment: .leading) {
					Text("Nom")
						.font(.title2)
						.bold()
					TextField("Ex : PayPal...", text: $accountName)
						.submitLabel(.done)
						.padding(12)
						.padding(.horizontal, 12)
						.background(Color.cellBackground)
						.cornerRadius(.infinity)
				}
				VStack(alignment: .leading) {
					HStack {
						Text("Icône")
							.font(.title2)
							.bold()
						Spacer()
						if #available(iOS 16.0, *) {
							NavigationLink {
								IconSelectorScreen()
							} label: {
								Text("Voir plus")
							}
						}
					}
					IconSelector(selectedIcon: $selectedIcon)
						.padding(.horizontal, -16)
				}
				VStack(alignment: .leading) {
					Text("Solde initial")
						.font(.title2)
						.bold()
					HStack {
						TextField("Ex : 486,73 \(selectedCurrency.rawValue)", text: $amount)
							.keyboardType(.numbersAndPunctuation)
							.submitLabel(.done)
							.padding(12)
							.padding(.horizontal, 12)
						CurrencySelector(selectedCurrency: $selectedCurrency)
							.foregroundColor(Color("purple"))
							.padding(4)
					}
					.background(Color.cellBackground)
					.cornerRadius(.infinity)
				}
				Spacer()
				MainButton(title: "Créer") {
					let newAccount = Account(
						iconName: selectedIcon,
						name: accountName,
						initialAmount: Float(amount) ?? 0,
						transactions: [],
						currency: selectedCurrency
					)
					onAccountCreated(newAccount)
					presentationMode.wrappedValue.dismiss()
				}
			}
			.padding()
			.background(Color.appBackground)
			.navigationTitle(Text("Nouveau compte"))
			.navigationBarHidden(true)
		}
    }
}

struct AccountCreationView_Previews: PreviewProvider {
    static var previews: some View {
		AccountCreationView { _ in
			return
		}
    }
}
