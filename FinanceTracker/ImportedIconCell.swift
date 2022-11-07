//
//  ImportedIconCell.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 07/11/2022.
//

import SwiftUI

struct ImportedIconCell: View {
	
	let data: Data
	let isSelected: Bool
	let onTap: () -> Void
	
    var body: some View {
		Button {
			onTap()
		} label: {
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
		}

    }
}

struct ImportedIconCell_Previews: PreviewProvider {
    static var previews: some View {
		VStack(spacing: 36) {
			ImportedIconCell(data: UIImage(named: "test_icon")!.pngData()!, isSelected: false, onTap: {})
			ImportedIconCell(data: UIImage(named: "test_icon")!.pngData()!, isSelected: true, onTap: {})
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.appBackground)
    }
}
