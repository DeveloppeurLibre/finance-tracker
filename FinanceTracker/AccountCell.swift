//
//  AccountCell.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 27/05/2022.
//

import SwiftUI

struct AccountCell: View {
	
	let iconName: String
	let name: String
	let amount: Float
	
    var body: some View {
		HStack(alignment: .center, spacing: 8) {
			Image(iconName)
				.resizable()
				.padding(4)
				.frame(width: 50, height: 50)
			VStack(alignment: .leading, spacing: 4) {
				Text(name)
					.font(.headline)
					.foregroundColor(.primary)
				Text("Solde : \(String(format: "%.2f", amount)) €")
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

struct AccountCell_Previews: PreviewProvider {
    static var previews: some View {
		AccountCell(iconName: "icon_002", name: "PayPal", amount: 3259.60)
			.padding()
			.background(Color("grey"))
			.previewLayout(.sizeThatFits)
    }
}
