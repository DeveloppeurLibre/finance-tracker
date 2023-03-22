//
//  ModalNavigationExample.swift
//  TestProject
//
//  Created by Quentin Cornu on 22/03/2023.
//

import SwiftUI

struct ModalNavigationExample: View {
    
    @State private var newPageIsPresented = false
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button {
                newPageIsPresented = true
            } label: {
                Text("Show destination")
            }
            Text(newPageIsPresented ? "Présentée" : "Cachée")
        }
        // Navigation modale
        .sheet(isPresented: $newPageIsPresented) {
            // Ecran de destination
            ModalView()
        }
    }
}

struct ModalNavigationExample_Previews: PreviewProvider {
    static var previews: some View {
        ModalNavigationExample()
    }
}
