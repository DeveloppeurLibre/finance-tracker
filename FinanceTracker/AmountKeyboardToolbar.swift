//
//  AmountKeyboardToolbar.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/11/2022.
//

import SwiftUI

struct AmountKeyboardToolbar: View {
	
	let onValidate: () -> Void
	let onNegativePressed: () -> Void
	let onPositivePressed: () -> Void
	
    var body: some View {
		HStack {
			Button {
				onNegativePressed()
			} label: {
				Image(systemName: "minus.circle.fill")
					.font(.system(size: 34))
					.foregroundColor(.cancel)
			}
			Button {
				onValidate()
			} label: {
				Text("Valider")
					.frame(maxWidth: .infinity)
					.foregroundColor(.mainButtonText)
					.padding(8)
					.background(Color.mainButtonBackground)
					.cornerRadius(.infinity)
			}
			Button {
				onPositivePressed()
			} label: {
				Image(systemName: "plus.circle.fill")
					.font(.system(size: 34))
					.foregroundColor(.validate)
			}
		}
		.padding(10)
		.background(Color.appBackground)
    }
}

struct AmountKeyboardToolbar_Previews: PreviewProvider {
    static var previews: some View {
		AmountKeyboardToolbar(onValidate: {}, onNegativePressed: {}, onPositivePressed: {})
			.previewLayout(.sizeThatFits)
    }
}
