//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 24/05/2022.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack {
			AccountCell(iconName: "icon_001", name: "Boursorama", amount: 2465.23)
			AccountCell(iconName: "icon_002", name: "PayPal", amount: 163.09)
			AccountCell(iconName: "icon_003", name: "Transport", amount: 23.53)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
