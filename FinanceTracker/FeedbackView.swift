//
//  FeedbackView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import SwiftUI

struct FeedbackView: View {
	
	@Environment(\.presentationMode) private var presentationMode
	@State private var message: String = ""
	
    var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			HStack(alignment: .top) {
				Text("A toi de jouer !")
					.font(.system(size: 32, weight: .bold))
					.padding(.top)
				Spacer()
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Image(systemName: "multiply")
						.imageScale(.large)
						.foregroundColor(.mainText)
				}

			}
			Text("Une idée d'amélioration ? Un bug ? Ou juste une remarque sur l'app ? Dis-nous tout ce qui pourrait rendre l'app encore meilleure !")
				.foregroundColor(.secondaryText)
				.font(.system(size: 14))
			ZStack(alignment: .topLeading) {
				if #available(iOS 16.0, *) {
					TextEditor(text: $message)
						.scrollContentBackground(.hidden)
						
				} else {
					TextEditor(text: $message)
				}
				if message.isEmpty {
					Text("Entrez votre message...")
						.padding(.horizontal, 4)
						.padding(.vertical, 8)
						.foregroundColor(.black)
						.opacity(0.25)
				}
			}
			.padding()
			.background(Color.cellBackground)
			.cornerRadius(20)
			Button {
				//
			} label: {
				Text("Ne plus afficher le bouton \"Feedback\"")
					.frame(maxWidth: .infinity)
					.foregroundColor(.red)
			}
			Text("Tu pourras toujours l'afficher à nouveau dans tes paramètres.")
				.foregroundColor(.secondaryText)
				.font(.system(size: 14))
				.opacity(0.5)
			MainButton(title: "Envoyer !") {
				
			}
		}
		.padding()
		.background(Color.appBackground)
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
