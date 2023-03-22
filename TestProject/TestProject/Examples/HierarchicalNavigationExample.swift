//
//  HierarchicalNavigationExample.swift
//  TestProject
//
//  Created by Quentin Cornu on 22/03/2023.
//

import SwiftUI

struct HierarchicalNavigationExample: View {
    var body: some View {
        // 1 - Ajouter une NavigationView
        NavigationView {
            List {
                // 3 - Ajouter un NavigationLink
                NavigationLink {
                    Rectangle()
                        .foregroundColor(.red)
                        .navigationTitle("Conversation 1")
                } label: {
                    Text("Conversation 1")
                }
                Text("Conversation 2")
                Text("Conversation 3")
            }
            // (2 - optionnel) Ajouter un titre de navigation
            .navigationTitle("Mes messages")
        }
    }
}

struct HierarchicalNavigationExample_Previews: PreviewProvider {
    static var previews: some View {
        HierarchicalNavigationExample()
    }
}
