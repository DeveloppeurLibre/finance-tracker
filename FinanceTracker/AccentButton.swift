//
//  AccentButton.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/06/2022.
//

import SwiftUI

struct AccentButton: View {
	
	let title: String
	let color: Color
	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			Text(title)
				.foregroundColor(Color.accentButtonText)
				.font(.callout)
				.fontWeight(.semibold)
				.frame(maxWidth: .infinity)
				.padding(8)
				.background(color)
				.cornerRadius(10)
		}
	}
}

struct AccentButton_Previews: PreviewProvider {
	static var previews: some View {
		AccentButton(title: "Test Button", color: Color("orange"), action: {})
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
