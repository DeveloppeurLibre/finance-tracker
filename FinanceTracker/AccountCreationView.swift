//
//  AccountCreationView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 04/06/2022.
//

import SwiftUI

struct AccountCreationView: View {
	
	@State private var amount: String = ""
	@State private var selectedIcon: String = "icon_001"
	@State private var selectedCurrency: Currency = .euro
	
    var body: some View {
		VStack(spacing: 32) {
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
