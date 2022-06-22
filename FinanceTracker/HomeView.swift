//
//  HomeView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 24/05/2022.
//

import SwiftUI

struct HomeView: View {
	
	@State private var isPresentingNewAccountScreen = false
	@StateObject var accountsList = AccountsList()
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 32) {
					VStack(spacing: 8) {
						Text("Solde total :")
						Text("\(String(format: "%.2f", accountsList.accounts.map { $0.amount }.reduce(0, +))) €")
							.font(.system(size: 32, weight: .bold))
					}
					.frame(maxWidth: .infinity)
					AccentButton(title: "+ account", color: Color("orange")) {
						isPresentingNewAccountScreen = true
					}
					VStack(alignment: .leading) {
						Text("Mes comptes")
							.font(.title2)
							.bold()
						if accountsList.accounts.count > 0 {
							VStack(spacing: 16) {
								ForEach(accountsList.accounts) { account in
									NavigationLink {
										AccountDetailView(account: account)
											.environmentObject(accountsList)
									} label: {
										AccountCell(account: account)
									}
								}
							}
						} else {
							Text("Ajoutez un compte")
								.padding(32)
								.frame(maxWidth: .infinity)
						}
					}
				}
				.padding(24)
			}
			.background(Color("grey"))
			.sheet(isPresented: $isPresentingNewAccountScreen) {
				AccountCreationView { newAccount in
					accountsList.accounts.append(newAccount)
				}
			}
		}
		.accentColor(.black)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
