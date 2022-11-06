//
//  SettingsScreen.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 02/11/2022.
//

import SwiftUI


extension UICollectionReusableView {
	override open var backgroundColor: UIColor? {
		get { .clear }
		set { }
	}
}

struct SettingsScreen: View {
	
	@EnvironmentObject var userPreferences: UserPreferences
	
	init() {
		UICollectionView.appearance().backgroundColor = .clear
		let navBarAppearance = UINavigationBar.appearance()
		navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.mainText)]
		navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.mainText)]
	}
	
	var body: some View {
		List {
			Section {
				Toggle(isOn: $userPreferences.showFeedbackButton) {
					Text("Afficher le bouton \"Feedback\"")
				}
				.listRowBackground(Color.cellBackground)
			} header: {
				Text("Mes préférences")
			}
		}
		.background(Color.appBackground)
		.navigationTitle(Text("Paramètres"))
	}
}

struct SettingsScreen_Previews: PreviewProvider {
	static var previews: some View {
		SettingsScreen()
			.environmentObject(UserPreferences())
	}
}

