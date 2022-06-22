//
//  AccountDetailView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 15/06/2022.
//

import SwiftUI

struct AccountDetailView: View {
	
	@ObservedObject var account: Account
	@State private var isPresentingNewTransactionScreen = false
	
    var body: some View {
		ScrollView {
			VStack(spacing: 24) {
				HStack {
					Text(account.name)
						.font(.system(size: 32, weight: .bold))
					Spacer()
					Text("\(String(format: "%.2f", account.amount)) \(account.currency.rawValue)")
						.font(.system(size: 32, weight: .light))
				}
				AccentButton(title: "+ transaction", color: Color("purple")) {
					isPresentingNewTransactionScreen = true
				}
				Divider()
				VStack(spacing: 16) {
					if account.transactions.isEmpty {
						Text("Aucune transaction pour le moment...")
							.font(.callout)
							.foregroundColor(Color(white: 0.4))
					}
					ForEach(account.transactions) { transaction in
						TransactionCell(transaction: transaction)
					}
					Text("Solde initial : \(String(format: "%.2f", account.initialAmount)) \(account.currency.rawValue)")
						.font(.callout)
						.foregroundColor(Color(white: 0.4))
						.padding()
				}
			}
			.padding()
		}
		.background(Color("grey"))
		.sheet(isPresented: $isPresentingNewTransactionScreen, content: {
			NewTransactionView()
		})
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			AccountDetailView(account: previewAccounts[0])
		}
    }
}
