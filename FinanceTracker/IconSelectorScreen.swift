//
//  IconSelectorScreen.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/11/2022.
//

import PhotosUI
import SwiftUI

@available(iOS 16.0, *)
struct IconSelectorScreen: View {
	
	@State private var selectedIcon: String = "icon_001"
	@State private var selectedItems: [PhotosPickerItem] = []
	@State private var selectedImagesData: [Data] = []
	
	private let icons = [
		"icon_001",
		"icon_002",
		"icon_003",
		"icon_004",
		"icon_005",
		"icon_006",
		"icon_007",
		"icon_008",
		"icon_009",
		"icon_010",
		"icon_012",
		"icon_013",
		"icon_014",
		"icon_015",
		"icon_016",
		"icon_017",
		"icon_018",
		"icon_019",
		"icon_020"
	]
	
	
	private let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
    var body: some View {
		ScrollView {
			Text("Icônes par défaut")
				.font(.title2)
				.bold()
			LazyVGrid(columns: columns, spacing: 20) {
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
			Text("Importer des icônes")
				.font(.title2)
				.bold()
			LazyVGrid(columns: columns, spacing: 20) {
				PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
					Circle()
						.frame(width: 65, height: 65)
						.foregroundColor(Color.pillBackground.opacity(0.8))
						.overlay(
							Image(systemName: "plus")
								.font(.system(size: 24, weight: .semibold))
								.foregroundColor(.mainText)
								.frame(width: 35, height: 35)
						)
				}
				
				ForEach(selectedImagesData, id: \.self) { data in
					ImportedIconCell(data: data, isSelected: false, onTap: {
						
					})
				}
			}
		}
		.background(Color.appBackground)
		.onChange(of: selectedItems) { newValue in
			guard let item = newValue.first else { return }
			item.loadTransferable(type: Data.self) { result in
				switch result {
					case .success(let data):
						if let data {
							self.selectedImagesData.append(data)
							self.selectedItems = []
						} else {
							print("Data is nil")
						}
					case .failure(let failure):
						print(failure)
				}
			}
		}
    }
}

@available(iOS 16.0, *)
struct IconSelectorScreen_Previews: PreviewProvider {
	static var previews: some View {
        IconSelectorScreen()
    }
}
