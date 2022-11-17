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
	let displayMode: DisplayMode
	let onTap: (() -> Void)?
	
	init(icon: Icon, isSelected: Bool = false, displayMode: DisplayMode = .normal, onTap: (() -> Void)? = nil) {
		self.icon = icon
		self.isSelected = isSelected
		self.displayMode = displayMode
		self.onTap = onTap
	}
	
	private var cellSize: CGFloat {
		switch displayMode {
			case .large:
				return 90
			case .normal:
				return 65
			case .small:
				return 50
		}
	}
	
    private func imageURL(for fileName: String) -> URL {
        let path = try! FileManager.default.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: false)
        return path.appendingPathComponent(fileName)
    }
    
    var body: some View {
		Button {
			onTap?()
		} label: {
			switch icon {
				case .imported(let fileName):
					Group {
                        if let data = imageURL(for: fileName).loadData(), let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: cellSize, height: cellSize)
								.clipShape(Circle())
						} else {
							Circle()
								.foregroundColor(.pillBackground)
						}
					}
					.frame(width: cellSize, height: cellSize)
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
					switch displayMode {
						case .large:
							Image(name)
								.renderingMode(.template)
								.resizable()
								.padding(4)
								.frame(width: cellSize, height: cellSize)
						case .normal:
							Circle()
								.frame(width: cellSize, height: cellSize)
								.foregroundColor(isSelected ? Color.pillSelectedBackground : Color.pillBackground)
								.overlay(
									Image(name)
										.resizable()
										.renderingMode(.template)
										.foregroundColor(isSelected ? .mainButtonText : .mainText)
										.frame(width: 35, height: 35)
								)
						case .small:
							Image(name)
								.renderingMode(.template)
								.resizable()
								.padding(4)
								.frame(width: cellSize, height: cellSize)
					}
					
			}
		}
    }
	
	enum DisplayMode {
		case large
		case normal
		case small
	}
}

struct ImportedIconCell_Previews: PreviewProvider {
    static var previews: some View {
		VStack(spacing: 36) {
//			IconCell(
//                icon: .imported(url: UIImage(named: "test_icon")!.pngData()!),
//				isSelected: false,
//				onTap: {}
//			)
//			IconCell(
//                icon: .imported(url: UIImage(named: "test_icon")!.pngData()!),
//				isSelected: true,
//				onTap: {}
//			)
			IconCell(
                icon: .native(iconName: "icon_001"),
				isSelected: false,
				onTap: {}
			)
			IconCell(
                icon: .native(iconName: "icon_001"),
				isSelected: true,
				onTap: {}
			)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.appBackground)
    }
}
