//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 24/05/2022.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		HStack(alignment: .center, spacing: 8) {
			Image("icon_002")
				.resizable()
				.padding(4)
				.frame(width: 50, height: 50)
			VStack(alignment: .leading, spacing: 4) {
				Text("PayPal")
					.font(.headline)
					.foregroundColor(.primary)
				Text("Solde : 3259.60 €")
					.font(.footnote)
					.foregroundColor(Color(white: 0.4))
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.background(Color.white)
		.cornerRadius(16)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.padding()
			.background(Color("grey"))
			.previewLayout(.sizeThatFits)
	}
}
