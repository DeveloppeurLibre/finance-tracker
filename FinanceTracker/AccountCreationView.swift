//
//  AccountCreationView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 04/06/2022.
//

import SwiftUI

struct AccountCreationView: View {
	
	@State private var accountName: String = ""
	@State private var amount: String = ""
	@State private var selectedIcon: String = "icon_001"
	@State private var selectedCurrency: Currency = .euro
	
    var body: some View {
		VStack(spacing: 32) {
			VStack(spacing: 16) {
				Text(accountName == "" ? "Nouveau compte" : accountName)
					.font(.system(size: 32, weight: .bold))
					.padding(.top, 32)
				Text("Solde : \(String(format: "%.2f", Float(amount) ?? 0.0)) \(selectedCurrency.rawValue)")
					.font(.system(size: 20, weight: .light))
					.foregroundColor(Color(white: 0.4))
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
					.background(Color.white)
					.cornerRadius(.infinity)
			}
			VStack(alignment: .leading) {
				Text("Icône")
					.font(.title2)
					.bold()
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
				.background(Color.white)
				.cornerRadius(.infinity)
			}
			Spacer()
			MainButton(title: "Créer") {
				// Action du bouton
			}
		}
		.padding()
		.background(Color("grey"))
    }
}

struct AccountCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreationView()
    }
}
