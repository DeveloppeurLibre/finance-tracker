//
//  FeedbackFloatingButtonModifier.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import SwiftUI

struct FeedbackFloatingButtonModifier: ViewModifier {
	
	private let preferenceRepository = PreferenceRepository()
	@EnvironmentObject var userPreferences: UserPreferences
	@State private var isShowingAlert = false
	@State private var isShowingFeedbackView = false
	
	func body(content: Content) -> some View {
		content
			.overlay(alignment: .bottomTrailing) {
				FeedbackFloatingButton {
					if userPreferences.hasReadFeedbackButtonAlertMessage {
						isShowingFeedbackView = true
					} else {
						isShowingAlert = true
					}
				}
				.opacity(userPreferences.showFeedbackButton ? 1 : 0)
				.animation(.easeInOut(duration: 0.2), value: userPreferences.showFeedbackButton)
			}
			.alert(isPresented: $isShowingAlert) {
				Alert(
					title: Text("Bouton \"Feedback\" 💡"),
					message: Text("Une idée de fonctionnalité ? Un bug à corriger ? Ou simplement un avis à donner sur l'app ? Utilise ce bouton à tout moment."),
					primaryButton: .default(Text("J'ai compris"), action: {
						isShowingFeedbackView = true
						userPreferences.hasReadFeedbackButtonAlertMessage = true
						preferenceRepository.save(userPreferences: userPreferences) { result in
							if case .failure(let error) = result {
								fatalError(error.localizedDescription)
							}
						}
					}),
					secondaryButton: .default(Text("Annuler"))
				)
			}
			.sheet(isPresented: $isShowingFeedbackView) {
				FeedbackView()
			}
	}
}

extension View {
	func feedbackFloatingButton(isShowingButton: Binding<Bool> = .constant(true)) -> some View {
		modifier(FeedbackFloatingButtonModifier())
	}
}

struct FeedbackFloatingButtonModifier_Previews: PreviewProvider {
	
	static var previews: some View {
		Rectangle()
			.foregroundColor(.clear)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color.appBackground)
			.feedbackFloatingButton()
	}
}
