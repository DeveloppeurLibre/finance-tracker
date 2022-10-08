//
//  CurrencySelector.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 04/06/2022.
//

import SwiftUI

struct CurrencySelector: View {
	
	@Binding var selectedCurrency: Currency
	@State private var isSelectingMode = false
	private let currencies = Currency.allCases
	
    var body: some View {
		ZStack {
			ForEach(currencies.indices) { index in
				Image(systemName: selectedCurrency == currencies[index] ? currencies[index].filledIconName : currencies[index].iconName)
					.foregroundColor(Color.mainText)
					.font(.system(size: 32))
					.offset(x: isSelectingMode ? -CGFloat(index) * 40 : 0, y: 0)
					.opacity(selectedCurrency == currencies[index] || isSelectingMode ? 1 : 0)
					.onTapGesture {
						if isSelectingMode {
							selectedCurrency = currencies[index]
						}
						withAnimation(.easeInOut(duration: 0.2)) {
							isSelectingMode.toggle()
						}
					}
			}
		}
    }
}

struct CurrencySelector_Previews: PreviewProvider {
	
	@State static var previewSelectedCurrency: Currency = .dollar
	
    static var previews: some View {
		CurrencySelector(selectedCurrency: $previewSelectedCurrency)
			.padding()
			.previewLayout(.sizeThatFits)
    }
}
