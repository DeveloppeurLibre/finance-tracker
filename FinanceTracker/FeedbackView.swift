//
//  FeedbackView.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import SwiftUI

struct FeedbackView: View {
	
	@EnvironmentObject var userPreferences: UserPreferences
	@Environment(\.presentationMode) private var presentationMode
	
	private let airTableRepository = AirTableRepository()
	private let preferenceRepository = PreferenceRepository()
	
	@State private var message: String = ""
	@State private var isShowingAlert = false
	
    var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			HStack(alignment: .top) {
				Text("À toi de jouer !")
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
						.foregroundColor(.mainText)
						.opacity(0.25)
				}
			}
			.padding()
			.background(Color.cellBackground)
			.cornerRadius(20)
			Button {
				isShowingAlert = true
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
				airTableRepository.postFeedback(message: message, completion: {
					presentationMode.wrappedValue.dismiss()
				})
			}
		}
		.padding()
		.background(Color.appBackground)
		.alert(isPresented: $isShowingAlert) {
			Alert(
				title: Text("Ne plus afficher le bouton"),
				message: Text("Le bouton \"Feedback\" ne sera plus affiché. Vous pourrez toujours l'afficher à nouveau dans les paramètres de l'app."),
				primaryButton: .default(Text("Continuer"), action: {
					userPreferences.showFeedbackButton = false
					preferenceRepository.save(userPreferences: userPreferences) { result in
						if case .failure(let error) = result {
							fatalError(error.localizedDescription)
						}
					}
					presentationMode.wrappedValue.dismiss()
				}),
				secondaryButton: .default(Text("Annuler"))
			)
		}
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
