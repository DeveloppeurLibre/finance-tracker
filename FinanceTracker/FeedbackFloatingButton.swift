//
//  FeedbackFloatingButton.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import SwiftUI

struct FeedbackFloatingButton: View {
	
	let action: () -> Void
	private let size: CGFloat = 70
	
	var body: some View {
		Button {
			action()
		} label: {
			Circle()
				.frame(width: size, height: size)
				.foregroundColor(Color.feedbackButtonBackground)
				.shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 10)
				.padding()
				.overlay {
					Image(systemName: "exclamationmark.bubble")
						.foregroundColor(Color.mainButtonText)
						.font(.system(size: 22, weight: .semibold))
						.opacity(0.8)
				}
		}
	}
}

struct FeedbackFloatingButton_Previews: PreviewProvider {
	static var previews: some View {
		ZStack(alignment: .bottomTrailing) {
			Rectangle()
				.foregroundColor(.clear)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			FeedbackFloatingButton(action: {})
		}
		.background(Color.appBackground)
    }
}
