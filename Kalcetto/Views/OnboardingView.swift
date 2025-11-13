import SwiftUI

struct OnboardingView: View {
	@EnvironmentObject var appState: AppState
	var body: some View {
		ZStack {
			Image("OnboardingBackground")
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
			VStack(alignment: .leading, spacing: 12) {
				Spacer()
				Text("onboarding_title")
					.font(.largeTitle)
					.bold()
					.foregroundStyle(.white)
				Text("onboarding_subtitle")
					.font(.body)
					.foregroundStyle(.white)
					.opacity(0.8)
				Button(action: {
					// Simulate or perform any setup work here; for now, immediately complete onboarding
					appState.completeOnboarding()
				}) {
					Text("onboarding_cta")
						.font(.headline)
						.frame(maxWidth: .infinity)
						.foregroundStyle(Color("TextColorInverted"))
				}
				.padding(.top, 12)
				.buttonStyle(.glassProminent)
				.controlSize(.large)
				.tint(Color("AccentColor"))
			}
			.padding(.horizontal, 24)
			.safeAreaPadding(.bottom)
			.padding(.bottom, 48)
		}
	}
}

#Preview {
	OnboardingView()
		.environmentObject(AppState())
}
