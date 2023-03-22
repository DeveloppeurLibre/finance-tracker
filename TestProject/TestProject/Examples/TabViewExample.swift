//
//  TabViewExample.swift
//  TestProject
//
//  Created by Quentin Cornu on 22/03/2023.
//

import SwiftUI

struct TabViewExample: View {
    var body: some View {
        // 1 - Créer une TabView
        TabView {
            // 2 - Dedans, ajouter autant de vues qu'on veut
            Rectangle()
                .foregroundColor(.red)
                // 3 - Pour chaque vue, ajouter un .tabItem
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Rectangle()
                .foregroundColor(.yellow)
                .tabItem {
                    Label("Messages", systemImage: "paperplane")
                }
            Rectangle()
                .foregroundColor(.green)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}

struct TabViewExample_Previews: PreviewProvider {
    static var previews: some View {
        TabViewExample()
    }
}
