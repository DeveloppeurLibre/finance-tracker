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
	@State private var isEditingMode = false
	@State private var isPresentingInitialAmountAlert = false
	@State private var newInitialAmount = ""
	@FocusState private var focusedField: Field?
	
	var body: some View {
		ScrollView {
			VStack(spacing: 24) {
				HStack {
					if isEditingMode {
						TextField("Entrez un nom...", text: $account.name)
							.font(.system(size: 32, weight: .bold))
							.focused($focusedField, equals: .name)
					} else {
						Text(account.name)
							.font(.system(size: 32, weight: .bold))
					}
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
		.background(Color.appBackground)
		.sheet(isPresented: $isPresentingNewTransactionScreen, content: {
			NewTransactionView(selectedAccountId: account.id)
		})
		.toolbar {
			Menu {
				Button {
					isEditingMode = true
					focusedField = .name
				} label: {
					Label("Renommer", systemImage: "pencil")
				}
				Button {
					isPresentingInitialAmountAlert = true
				} label: {
					Label("Modifier le solde initial", systemImage: account.currency.iconName)
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
		.sheet(isPresented: $isShowingAlert) {
			Text("Hello")
		}
		.alert("Attends !", isPresented: $isShowingAlert, actions: {
			Text("Hello")
			Button("Supprimer", role: .destructive) {
				accountsList.accounts.removeAll { element in
					element.id == account.id
				}
				presentationMode.wrappedValue.dismiss()
			}
			Button("Annuler", role: .cancel) {
				isShowingAlert = false
			}
		}, message: {
			Text("Es-tu sûr de vouloir supprimer ce compte ? Toutes les transactions liées seront perdues.")
		})
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
		.alert("Modifier le solde initial", isPresented: $isPresentingInitialAmountAlert, actions: {
			TextField("Nouveau montant", text: $newInitialAmount)
			Button("Annuler", role: .cancel) {
				isPresentingInitialAmountAlert = false
			}
			Button {
				if let newAmount = Float(newInitialAmount) {
					account.initialAmount = newAmount
				}
				isPresentingInitialAmountAlert = false
			} label: {
				Text("Confirmer")
			}
		}, message: {
			Text("Quel est le nouveau montant initial souhaité ?")
		})
	}
	
	private enum Field: Int, Hashable {
		case name
	}
}

struct AccountDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			AccountDetailView(account: previewAccounts[0])
				.environmentObject(AccountsList(accounts: previewAccounts))
		}
	}
}
