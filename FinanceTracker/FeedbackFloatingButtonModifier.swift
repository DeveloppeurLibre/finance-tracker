//
//  FeedbackFloatingButtonModifier.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import SwiftUI

struct FeedbackFloatingButtonModifier: ViewModifier {
	
	let isShowingButton: Binding<Bool>
	let action: () -> Void
	
	func body(content: Content) -> some View {
		if isShowingButton.wrappedValue {
			content
				.overlay(alignment: .bottomTrailing) {
					FeedbackFloatingButton {
						action()
					}
				}
		} else {
			content
		}			
	}
}

extension View {
	func feedbackFloatingButton(isShowingButton: Binding<Bool> = .constant(true), action: @escaping () -> Void) -> some View {
		modifier(FeedbackFloatingButtonModifier(isShowingButton: isShowingButton, action: action))
	}
}

struct FeedbackFloatingButtonModifier_Previews: PreviewProvider {
	
    static var previews: some View {
        Rectangle()
			.foregroundColor(.clear)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color.appBackground)
			.feedbackFloatingButton(action: {})
    }
}
