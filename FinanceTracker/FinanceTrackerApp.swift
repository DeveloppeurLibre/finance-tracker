//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 24/05/2022.
//

import SwiftUI

@main
struct FinanceTrackerApp: App {
	
	@StateObject private var userPreferences = UserPreferences()
	
    var body: some Scene {
        WindowGroup {
            HomeView()
				.environmentObject(userPreferences)
				.onAppear {
					PreferenceRepository().createPreferenceFileIfNedded()
				}
        }
    }
}
