import SwiftUI

struct RootView: View {
	@EnvironmentObject var appState: AppState

	var body: some View {
		ZStack {
			if !appState.hasCompletedOnboarding {
				OnboardingView()
					.transition(.opacity.combined(with: .scale(scale: 0.95)))
			} else if !appState.isLoggedIn {
				AuthView()
					.transition(.opacity.combined(with: .move(edge: .trailing)))
			} else if !appState.hasCompletedProfileSetup {
				ProfileSetupView()
					.transition(.opacity.combined(with: .move(edge: .bottom)))
			} else {
				MainTabView()
					.transition(.opacity.combined(with: .scale(scale: 1.05)))
			}
		}
		.animation(
			.easeInOut(duration: 0.4),
			value: appState.hasCompletedOnboarding
		)
		.animation(.easeInOut(duration: 0.4), value: appState.isLoggedIn)
		.animation(
			.easeInOut(duration: 0.4),
			value: appState.hasCompletedProfileSetup
		)
	}
}
