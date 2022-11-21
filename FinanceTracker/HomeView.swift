//
//  HomeView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 24/05/2022.
//

import SwiftUI

struct HomeView: View {
	
	private let preferenceRepository = PreferenceRepository()
	@Environment(\.scenePhase) private var scenePhase
	@EnvironmentObject var userPreferences: UserPreferences
	
	@State private var isPresentingNewAccountScreen = false
	@State private var isPresentingNewTransactionScreen = false
	@State private var isShowingFavouritesOnly = false
	@State private var isShowingAlert = false
	@StateObject var accountsList = AccountsList(accounts: previewAccounts)
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 32) {
					ZStack(alignment: .topTrailing) {
						VStack(spacing: 32) {
							VStack(spacing: 8) {
								Text("Solde total :")
                                Text(accountsList.accounts.map { $0.amount }.reduce(0, +).localizedString + " €")
									.font(.system(size: 32, weight: .bold))
							}
							.frame(maxWidth: .infinity)
							HStack(spacing: 16) {
								AccentButton(title: "+ transaction", color: Color("purple")) {
									if accountsList.accounts.isEmpty {
										isShowingAlert = true
									} else {
										isPresentingNewTransactionScreen = true
									}
								}
								AccentButton(title: "+ account", color: Color("orange")) {
									isPresentingNewAccountScreen = true
								}
							}
						}
						.padding(.top, 24)
						NavigationLink {
							SettingsScreen()
						} label: {
							Image(systemName: "gearshape")
								.imageScale(.large)
						}
					}
					VStack(alignment: .leading) {
						HStack {
							Text("Mes comptes")
								.font(.title2)
								.bold()
							Spacer()
							Button {
								withAnimation {
									isShowingFavouritesOnly.toggle()
								}
							} label: {
								Image(systemName: isShowingFavouritesOnly ? "star.fill" : "star")
									.foregroundColor(isShowingFavouritesOnly ? .yellow : Color(white: 0.4))
									.padding(.trailing)
							}
						}
						
						if accountsList.accounts.count > 0 {
							VStack(spacing: 16) {
								ForEach(accountsList.accounts) { account in
									if !isShowingFavouritesOnly || account.isFavourite {
										NavigationLink {
											AccountDetailView(account: account)
												.environmentObject(accountsList)
										} label: {
											AccountCell(account: account)
										}
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
				.padding(.horizontal, 24)
				.padding(.bottom, 24)
			}
			.navigationBarHidden(true)
			.navigationTitle(Text("Mes comptes"))
			.background(Color.appBackground)
			.sheet(isPresented: $isPresentingNewAccountScreen) {
				AccountCreationView { newAccount in
					accountsList.accounts.append(newAccount)
				}
			}
			.sheet(isPresented: $isPresentingNewTransactionScreen) {
				NewTransactionView(selectedAccountId: nil)
					.environmentObject(accountsList)
			}
			.alert(isPresented: $isShowingAlert) {
				Alert(
					title: Text("Hop !"),
					message: Text("Tu dois d'abord créer un compte avant d'y associer des transactions. 😉"),
					primaryButton: .default(Text("Créer un compte"), action: {
						isPresentingNewAccountScreen = true
					}),
					secondaryButton: .default(Text("Annuler"))
				)
			}
		}
		.foregroundColor(Color.mainText)
		.accentColor(Color.mainText)
		.onChange(of: scenePhase) { phase in
			if phase == .inactive {
				AccountsList.save(accounts: accountsList.accounts) { result in
					if case .failure(let error) = result {
						fatalError(error.localizedDescription)
					}
				}
				preferenceRepository.save(userPreferences: userPreferences) { result in
					if case .failure(let error) = result {
						fatalError(error.localizedDescription)
					}
				}
			}
		}
		.onAppear {
			AccountsList.load { result in
				switch result {
					case .failure(let error):
						fatalError(error.localizedDescription)
					case .success(let accounts):
						accountsList.accounts = accounts
				}
			}
			preferenceRepository.load(completion: { result in
				switch result {
					case .success(let userPreferences):
						self.userPreferences.hasReadFeedbackButtonAlertMessage = userPreferences.hasReadFeedbackButtonAlertMessage
						self.userPreferences.showFeedbackButton = userPreferences.showFeedbackButton
					case .failure(let failure):
						print("Erreur : \(failure)")
				}
			})
		}
		.feedbackFloatingButton(isShowingButton: $userPreferences.showFeedbackButton)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
			.environmentObject(UserPreferences())
	}
}
