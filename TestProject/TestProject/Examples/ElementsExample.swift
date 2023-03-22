//
//  ElementsExample.swift
//  TestProject
//
//  Created by Quentin Cornu on 22/03/2023.
//

import SwiftUI

struct ElementsExample: View {
    
    @State private var toggleIsActive = false
    @State private var textFieldContent = ""
    @State private var selectedDate = Date.now
    @State private var stepperValue = 5
    
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Option fromage", isOn: $toggleIsActive)
            TextField("Placeholder", text: $textFieldContent)
            DatePicker("Date :", selection: $selectedDate)
            Stepper("Nombre de voitures : \(stepperValue)", value: $stepperValue)
            
        }
        .padding()
    }
}

struct ElementsExample_Previews: PreviewProvider {
    static var previews: some View {
        ElementsExample()
    }
}
