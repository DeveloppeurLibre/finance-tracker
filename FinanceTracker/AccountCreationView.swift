//
//  AccountCreationView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 04/06/2022.
//

import SwiftUI

struct AccountCreationView: View {
	
	@State private var amount: String = ""

    var body: some View {
		HStack {
			TextField("Ex : 486,73 ???", text: $amount)
				.keyboardType(.numbersAndPunctuation)
				.submitLabel(.done)
				.padding(12)
				.padding(.horizontal, 12)
			CurrencySelector()
				.foregroundColor(Color("purple"))
				.padding(4)
		}
		.background(Color.white)
		.cornerRadius(.infinity)
		.padding()
		.background(Color("grey"))
    }
}

struct AccountCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreationView()
    }
}
