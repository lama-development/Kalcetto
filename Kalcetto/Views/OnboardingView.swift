import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @State private var isPreparing = false
    var body: some View {
        ZStack {
            // Full-screen background image
            Image("OnboardingBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            // Bottom content
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
                    isPreparing = true
                    // Simulate or perform any setup work here; for now, immediately complete onboarding
                    appState.completeOnboarding()
                    isPreparing = false
                }) {
                    Text("onboarding_cta")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
												.foregroundStyle(.black)
                }
                .padding(.top, 12)
								.buttonStyle(.glassProminent)
                .controlSize(.large)
                .tint(.accentColor)
            }
            .padding(.horizontal, 24)
            .safeAreaPadding(.bottom)
            .padding(.bottom, 48)
            
            if isPreparing {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                ProgressView("Preparing…")
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black.opacity(0.6))
                    )
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
