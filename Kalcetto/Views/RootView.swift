import SwiftUI

struct RootView: View {
	@EnvironmentObject var appState: AppState

	var body: some View {
		ZStack {
			if !appState.hasCompletedOnboarding {
				OnboardingView()
			} else if !appState.isLoggedIn {
				AuthView()
			} else if !appState.hasCompletedProfileSetup {
				ProfileSetupView()
			} else {
				MainTabView()
			}
		}
	}
}
