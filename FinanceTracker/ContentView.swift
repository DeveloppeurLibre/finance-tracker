//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 24/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		HStack(alignment: .center) {
			Image("icon_002")
			VStack(alignment: .leading) {
				Text("PayPal")
				Text("Solde : 3259.60 €")
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
