//
//  ActivableButton.swift
//  TestProject
//
//  Created by Quentin Cornu on 21/03/2023.
//

import SwiftUI

struct ActivableButton: View {
    
    let iconName: String
    let activatedIconColor: Color
    // ⚠️ JAMAIS d'affectation de valeur à un Binding (jamais de "=")
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            Image(systemName: isActive ? iconName + ".fill" : "\(iconName)")
                .font(.system(size: 30))
                .foregroundColor(isActive ? activatedIconColor : .primary)
        }
    }
}

struct ActivableButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ActivableButton(
                iconName: "heart",
                activatedIconColor: .red,
                isActive: .constant(false)
            )
            ActivableButton(
                iconName: "flag",
                activatedIconColor: .black,
                isActive: .constant(true)
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
