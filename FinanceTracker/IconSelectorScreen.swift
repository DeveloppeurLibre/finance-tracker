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
	
	@Environment(\.presentationMode) var presentationMode

	@State private var selectedIcon: Icon = .native("icon_001")
	@State private var selectedItems: [PhotosPickerItem] = []
	@State private var selectedImagesData: [Data] = []
	
	let onIconSelected: (Icon) -> Void
	
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
		ScrollView(showsIndicators: false) {
			VStack(alignment: .leading, spacing: 32) {
				VStack(alignment: .leading, spacing: 16) {
					Text("Icônes par défaut")
						.font(.title2)
						.bold()
					LazyVGrid(columns: columns, spacing: 20) {
						ForEach(icons, id: \.self) { iconName in
							IconCell(
								icon: .native(iconName),
								isSelected: selectedIcon == .native(iconName),
								onTap: { selectedIcon = .native(iconName) }
							)
						}
					}
				}
				VStack(alignment: .leading, spacing: 24) {
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
							IconCell(
								icon: .imported(data),
								isSelected: selectedIcon == .imported(data),
								onTap: { selectedIcon = .imported(data) }
							)
						}
					}
				}
			}
			.padding(.bottom, 80)
		}
		.padding()
		.navigationBarTitleDisplayMode(.inline)
		.background(Color.appBackground)
		.overlay(alignment: .bottom, content: {
			MainButton(title: "Valider") {
				onIconSelected(selectedIcon)
				presentationMode.wrappedValue.dismiss()
			}
			.padding()
		})
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
		IconSelectorScreen(onIconSelected: { _ in })
    }
}
