import Combine
import SwiftUI

@MainActor
class AppState: ObservableObject {
	@Published var hasCompletedOnboarding: Bool
	@Published var isLoggedIn: Bool
	@Published var hasCompletedProfileSetup: Bool
	@Published var currentUser: User?

	init() {
		// For now, we just hardcode defaults.
		// Later you can load these from UserDefaults or Keychain.
		self.hasCompletedOnboarding = false
		self.isLoggedIn = false
		self.hasCompletedProfileSetup = false
		self.currentUser = nil
	}

	func completeOnboarding() {
		hasCompletedOnboarding = true
	}

	func logIn() {
		isLoggedIn = true
	}

	func logOut() {
		isLoggedIn = false
		hasCompletedProfileSetup = false
		currentUser = nil
	}
	
	func completeProfileSetup(with user: User) {
		currentUser = user
		hasCompletedProfileSetup = true
		// TODO: Save user data to UserDefaults or persistent storage
	}
}
