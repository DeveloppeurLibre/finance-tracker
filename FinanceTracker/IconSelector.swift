//
//  IconSelector.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 06/06/2022.
//

import SwiftUI

struct IconSelector: View {
	
	@Binding var selectedIcon: String
	
	private let icons = [
		"icon_001",
		"icon_002",
		"icon_003",
		"icon_004",
		"icon_005",
		"icon_006",
		"icon_007"
	]
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(icons, id: \.self) { iconName in
					Button {
						selectedIcon = iconName
					} label: {
						Circle()
							.frame(width: 65, height: 65)
							.foregroundColor(iconName == selectedIcon ? Color.pillSelectedBackground : Color.pillBackground)
							.overlay(
								Image(iconName)
									.resizable()
									.renderingMode(.template)
									.foregroundColor(iconName == selectedIcon ? .mainButtonText : .mainText)
									.frame(width: 35, height: 35)
							)
					}
				}
			}
			.padding(.horizontal, 16)
		}
	}
}

struct IconSelector_Previews: PreviewProvider {
	
	@State static var previewSelectedIcon = "icon_001"
	
	static var previews: some View {
		IconSelector(selectedIcon: $previewSelectedIcon)
			.padding(.vertical)
			.previewLayout(.sizeThatFits)
			.background(Color.appBackground)
	}
}
