//
//  TransactionCell.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 09/06/2022.
//

import SwiftUI

struct TransactionCell: View {
	
	@ObservedObject var transaction: Transaction
	let onDelete: () -> Void
	@State private var isDetailedMode = false
	@State private var isEditingMode = false
	@FocusState private var focusedField: Field?
	
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy à HH:mm"
		return formatter
	}()
	
    var body: some View {
		VStack(spacing: 16) {
			HStack {
				VStack(alignment: .leading, spacing: 4) {
					if isEditingMode {
						TextField("Ex : Repas du midi", text: $transaction.label)
							.focused($focusedField, equals: .label)
							.font(.headline)
					} else {
						if transaction.label == "" {
							if transaction.amount > 0 {
								Text("Des sous ! 🤑")
									.font(.headline)
							} else {
								Text("Une dépense 💸")
									.font(.headline)
							}
						} else {
							Text(transaction.label)
								.font(.headline)
						}
					}
					Text(dateFormatter.string(from: transaction.date))
						.font(.footnote)
						.foregroundColor(Color(white: 0.4))
				}
				Spacer()
                Text("\(transaction.amount.localizedString) \(transaction.currency.rawValue)")
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
						isEditingMode.toggle()
						focusedField = .label
					} label: {
						Text("Renommer")
							.foregroundColor(.blue)
							.frame(maxWidth: .infinity)
					}
				}
			}
		}
		.foregroundColor(Color.mainText)
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
		.background(Color.cellBackground)
		.cornerRadius(16)
		.onTapGesture {
			withAnimation {
				isDetailedMode.toggle()
			}
		}
    }
	
	private enum Field: Int, Hashable {
		case label
	}
}

struct TransactionCell_Previews: PreviewProvider {
    static var previews: some View {
		TransactionCell(transaction: previewTransactions[0], onDelete: {})
			.padding(24)
			.background(Color.appBackground)
			.previewLayout(.sizeThatFits)
    }
}
