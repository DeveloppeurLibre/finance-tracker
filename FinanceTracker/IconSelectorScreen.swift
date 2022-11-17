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

    @State private var selectedIcon: Icon = .native(iconName: "icon_001")
	@State private var selectedItems: [PhotosPickerItem] = []
	@State private var importedImagesFileNames: [String] = []
	
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
                                icon: .native(iconName: iconName),
                                isSelected: selectedIcon == .native(iconName: iconName),
                                onTap: { selectedIcon = .native(iconName: iconName) }
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
                        ForEach(importedImagesFileNames, id: \.self) { fileName in
							IconCell(
                                icon: .imported(fileName: fileName),
                                isSelected: selectedIcon == .imported(fileName: fileName),
                                onTap: { selectedIcon = .imported(fileName: fileName) }
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
                            do {
                                let path = try FileManager.default.url(for: .documentDirectory,
                                                                        in: .userDomainMask,
                                                                        appropriateFor: nil,
                                                                        create: false)
                                let fileName = "\(UUID()).jpg"
                                let url = path.appendingPathComponent(fileName)
                                print(url)
                                url.saveData(data)
                                self.importedImagesFileNames.append(fileName)
                            } catch {
                                print(error.localizedDescription)
                            }
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
