//
//  MainButton.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/06/2022.
//

import SwiftUI

struct MainButton: View {
	
	let title: String
	let action: () -> Void
	
	var body: some View {
		Button {
			action()
		} label: {
			Text(title)
				.font(.headline)
				.foregroundColor(Color.mainButtonText)
				.padding()
				.frame(maxWidth: .infinity)
				.background(Color.mainButtonBackground)
				.cornerRadius(.infinity)
		}
	}
}

struct MainButton_Previews: PreviewProvider {
	static var previews: some View {
		MainButton(title: "Hello!") {
			print("Hello!")
		}
	}
}
