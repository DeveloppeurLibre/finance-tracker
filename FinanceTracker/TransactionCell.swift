//
//  TransactionCell.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 09/06/2022.
//

import SwiftUI

struct TransactionCell: View {
	
	let transaction: Transaction
	
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy à HH:mm"
		return formatter
	}()
	
    var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 4) {
				Text(transaction.label)
					.font(.headline)
				Text(dateFormatter.string(from: transaction.date))
					.font(.footnote)
					.foregroundColor(Color(white: 0.4))
			}
			Spacer()
			Text("\(String(format: "%.2f", transaction.amount)) \(transaction.currency.rawValue)")
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.background(Color.white)
		.cornerRadius(16)
    }
}

struct TransactionCell_Previews: PreviewProvider {
    static var previews: some View {
		TransactionCell(transaction: previewTransactions[0])
			.padding(24)
			.background(Color("grey"))
			.previewLayout(.sizeThatFits)
    }
}
