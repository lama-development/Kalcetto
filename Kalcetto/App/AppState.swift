import SwiftUI
import Combine

@MainActor
class AppState: ObservableObject {
		@Published var hasCompletedOnboarding: Bool
		@Published var isLoggedIn: Bool

		init() {
				// For now, we just hardcode defaults.
				// Later you can load these from UserDefaults or Keychain.
				self.hasCompletedOnboarding = false
				self.isLoggedIn = false
		}

		func completeOnboarding() {
				hasCompletedOnboarding = true
		}

		func logIn() {
				isLoggedIn = true
		}

		func logOut() {
				isLoggedIn = false
		}
}
