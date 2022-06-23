//
//  TransactionCell.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 09/06/2022.
//

import SwiftUI

struct TransactionCell: View {
	
	let transaction: Transaction
	let onDelete: () -> Void
	@State private var isDetailedMode = false
	
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy à HH:mm"
		return formatter
	}()
	
    var body: some View {
		VStack(spacing: 16) {
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
			if isDetailedMode {
				HStack {
					Button {
						onDelete()
					} label: {
						Text("Supprimer")
							.foregroundColor(.red)
							.frame(maxWidth: .infinity)
					}
					Button {
						// à compléter
					} label: {
						Text("Renommer")
							.foregroundColor(.blue)
							.frame(maxWidth: .infinity)
					}
				}
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.background(Color.white)
		.cornerRadius(16)
		.onTapGesture {
			withAnimation {
				isDetailedMode.toggle()
			}
		}
    }
}

struct TransactionCell_Previews: PreviewProvider {
    static var previews: some View {
		TransactionCell(transaction: previewTransactions[0], onDelete: {})
			.padding(24)
			.background(Color("grey"))
			.previewLayout(.sizeThatFits)
    }
}
