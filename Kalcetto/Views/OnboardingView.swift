import SwiftUI

struct OnboardingView: View {
	@EnvironmentObject var appState: AppState
	var body: some View {
		ZStack {
			Image("OnboardingBackground")
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
			LinearGradient(
				gradient: Gradient(colors: [
					Color("AccentColor").opacity(0.3),
					Color.black.opacity(0.5),
				]),
				startPoint: .top,
				endPoint: .bottom
			)
			.ignoresSafeArea()
			VStack(alignment: .leading, spacing: 16) {
				Spacer()
				Text("onboarding_title")
					.font(.custom("Onest", size: 32))
					.fontWeight(.bold)
					.foregroundStyle(.white)
				Text("onboarding_subtitle")
					.font(.custom("Onest", size: 18))
					.fontWeight(.regular)
					.foregroundStyle(.white)
					.opacity(0.8)
				Button(action: {
					withAnimation(.easeInOut(duration: 0.3)) {
						appState.completeOnboarding()
					}
				}) {
					HStack {
						Text("onboarding_cta")
							.font(.custom("Onest", size: 18))
							.fontWeight(.semibold)
							.foregroundStyle(Color("TextColorInverted"))
					}
					.frame(maxWidth: .infinity)
					.frame(height: 48)
				}
				.buttonStyle(.glassProminent)
				.tint(Color("AccentColor"))
				.padding(.top, 12)
			}
			.padding(.horizontal, 28)
			.safeAreaPadding(.bottom)
			.padding(.bottom, 40)
		}
	}
}

#Preview {
	OnboardingView()
		.environmentObject(AppState())
}
