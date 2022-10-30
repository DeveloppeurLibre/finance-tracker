//
//  FeedbackFloatingButtonModifier.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import SwiftUI

struct FeedbackFloatingButtonModifier: ViewModifier {
	
	@State private var isShowingAlert = false
	@State private var isShowingFeedbackView = false
	
	let isShowingButton: Binding<Bool>
	
	func body(content: Content) -> some View {
		if isShowingButton.wrappedValue {
			content
				.overlay(alignment: .bottomTrailing) {
					FeedbackFloatingButton {
						isShowingAlert = true
					}
				}
				.alert(isPresented: $isShowingAlert) {
					Alert(
						title: Text("Une idée ? 💡"),
						message: Text("Tu as une idée de fonctionnalité ? Tu as remarqué un bug ? Ou tu veux tout simplement donner ton avis sur l'app ? Utilise ce bouton à tout moment."),
						primaryButton: .default(Text("Continuer"), action: {
							isShowingFeedbackView = true
						}),
						secondaryButton: .default(Text("Annuler"))
					)
				}
				.sheet(isPresented: $isShowingFeedbackView) {
					FeedbackView()
				}
		} else {
			content
		}			
	}
}

extension View {
	func feedbackFloatingButton(isShowingButton: Binding<Bool> = .constant(true)) -> some View {
		modifier(FeedbackFloatingButtonModifier(isShowingButton: isShowingButton))
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
