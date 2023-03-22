//
//  ListExamples.swift
//  TestProject
//
//  Created by Quentin Cornu on 21/03/2023.
//

import SwiftUI

struct Car: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

struct ListExamples: View {
    
    let myGarage = [
        Car(name: "Clio 3", color: .gray),
        Car(name: "Porsche 911", color: .blue),
        Car(name: "Tesla Model S", color: .red)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(myGarage) { car in
                    HStack {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(car.color)
                        Text(car.name)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.gray.opacity(0.2))
                }
            }
            .padding()
        }
    }
}

struct ListExamples_Previews: PreviewProvider {
    static var previews: some View {
        ListExamples()
    }
}
