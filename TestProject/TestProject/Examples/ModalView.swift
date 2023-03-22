//
//  ModalView.swift
//  TestProject
//
//  Created by Quentin Cornu on 22/03/2023.
//

import SwiftUI

struct ModalView: View {
    
//    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Destination")
                .foregroundColor(.red)
                .bold()
                .padding()
                .background(.blue)
            Button {
//                isPresented = false
                dismiss()
            } label: {
                Text("Retour")
                    .padding()
            }

        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
