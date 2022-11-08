//
//  IconCell.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/11/2022.
//

import SwiftUI

struct IconCell: View {
	
	let icon: Icon
	let isSelected: Bool
	let onTap: () -> Void
	
    var body: some View {
		Button {
			onTap()
		} label: {
			switch icon {
				case .imported(let data):
					Group {
						if let data = data, let uiImage = UIImage(data: data) {
							Image(uiImage: uiImage)
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 65, height: 65)
								.clipShape(Circle())
						} else {
							Circle()
								.foregroundColor(.pillBackground)
						}
					}
					.frame(width: 65, height: 65)
					.overlay {
						if isSelected {
							ZStack {
								Circle()
									.stroke(style: StrokeStyle(lineWidth: 3))
									.foregroundColor(.mainText)
								Circle()
									.stroke(style: StrokeStyle(lineWidth: 3))
									.foregroundColor(.appBackground)
									.scaleEffect(0.92)
							}
						}
					}
				case .native(let name):
					Circle()
						.frame(width: 65, height: 65)
						.foregroundColor(isSelected ? Color.pillSelectedBackground : Color.pillBackground)
						.overlay(
							Image(name)
								.resizable()
								.renderingMode(.template)
								.foregroundColor(isSelected ? .mainButtonText : .mainText)
								.frame(width: 35, height: 35)
						)
			}
		}
    }
}

struct ImportedIconCell_Previews: PreviewProvider {
    static var previews: some View {
		VStack(spacing: 36) {
			IconCell(
				icon: .imported(UIImage(named: "test_icon")!.pngData()!),
				isSelected: false,
				onTap: {}
			)
			IconCell(
				icon: .imported(UIImage(named: "test_icon")!.pngData()!),
				isSelected: true,
				onTap: {}
			)
			IconCell(
				icon: .native("icon_001"),
				isSelected: false,
				onTap: {}
			)
			IconCell(
				icon: .native("icon_001"),
				isSelected: true,
				onTap: {}
			)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.appBackground)
    }
}
