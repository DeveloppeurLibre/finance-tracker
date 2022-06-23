//
//  AccountDetailView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 15/06/2022.
//

import SwiftUI

struct AccountDetailView: View {
	
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var accountsList: AccountsList
	@ObservedObject var account: Account
	@State private var isPresentingNewTransactionScreen = false
	@State private var isShowingAlert = false
	@State private var isShowingTransactionAlert = false
	@State private var selectedTransactionToDelete: Transaction? = nil
	
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
						TransactionCell(transaction: transaction, onDelete: {
							selectedTransactionToDelete = transaction
							isShowingTransactionAlert = true
						})
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
		.toolbar {
			Menu {
				Button {
					// action
				} label: {
					Label("Renommer", systemImage: "pencil")
				}
				Button(role: .destructive) {
					isShowingAlert = true
				} label: {
					Label("Supprimer", systemImage: "trash")
				}
			} label: {
				Image(systemName: "slider.horizontal.3")
					.foregroundColor(.primary)
			}
		}
		.alert(isPresented: $isShowingAlert) {
			Alert(
				title: Text("Attends !"),
				message: Text("Es-tu sûr de vouloir supprimer ce compte ? Toutes les transactions liées seront perdues."),
				primaryButton: .destructive(Text("Supprimer"), action: {
					accountsList.accounts.removeAll { element in
						element.id == account.id
					}
					presentationMode.wrappedValue.dismiss()
				}),
				secondaryButton: .cancel(Text("Annuler"))
			)
		}
		.alert(isPresented: $isShowingTransactionAlert) {
			Alert(
				title: Text("Hmm..."),
				message: Text("Tu es sur le point de supprimer la transaction \"\(selectedTransactionToDelete!.label)\". Cette transaction sera perdue à jamais."),
				primaryButton: .destructive(Text("Supprimer"), action: {
					withAnimation {
						account.transactions.removeAll {
							selectedTransactionToDelete!.id == $0.id
						}
					}
					selectedTransactionToDelete = nil
				}),
				secondaryButton: .cancel(Text("Annuler"))
			)
		}
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			AccountDetailView(account: previewAccounts[0])
		}
    }
}
