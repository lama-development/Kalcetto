import SwiftUI

struct OnboardingView: View {
	@EnvironmentObject var appState: AppState
	@State private var isAnimating = false
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
					.opacity(isAnimating ? 1 : 0)
					.offset(y: isAnimating ? 0 : 20)
				Text("onboarding_subtitle")
					.font(.custom("Onest", size: 18))
					.fontWeight(.regular)
					.foregroundStyle(.white)
					.opacity(0.8)
					.opacity(isAnimating ? 1 : 0)
					.offset(y: isAnimating ? 0 : 20)
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
				.scaleEffect(isAnimating ? 1 : 0.9)
				.opacity(isAnimating ? 1 : 0)
			}
			.padding(.horizontal, 28)
			.safeAreaPadding(.bottom)
			.padding(.bottom, 40)
		}
		.onAppear {
			withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
				isAnimating = true
			}
		}
	}
}

#Preview {
	OnboardingView()
		.environmentObject(AppState())
}
