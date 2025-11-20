import AuthenticationServices
import SwiftUI

struct AuthView: View {
	@EnvironmentObject var appState: AppState
	@State private var showTermsSheet = false
	@Environment(\.openURL) var openURL
	
	var body: some View {
		ZStack {
			Color("BackgroundColor")
				.ignoresSafeArea()
			VStack(spacing: 0) {
				Spacer()
				VStack(spacing: 20) {
					Image("AppLogo")
						.resizable()
						.scaledToFit()
						.frame(width: 100, height: 100)
					VStack(alignment: .center, spacing: 10) {
						Text("auth_title")
							.font(.custom("Onest", size: 32))
							.fontWeight(.bold)
							.foregroundStyle(Color("TextColor"))
						Text("auth_subtitle")
							.font(.custom("Onest", size: 18))
							.fontWeight(.regular)
							.foregroundStyle(Color("TextColor"))
							.opacity(0.8)
							.multilineTextAlignment(.center)
							.padding(.horizontal, 20)
					}
					.padding(.bottom, 40)
					VStack(spacing: 16) {
						// Apple Sign-In
						SignInWithAppleButton(
							.signIn,
							onRequest: { request in
								request.requestedScopes = [.fullName, .email]
							},
							onCompletion: { result in
								switch result {
								case .success(_):
									withAnimation(.easeInOut(duration: 0.3)) {
										appState.logIn()
									}
								case .failure(let error):
									print("Apple Sign-In failed: \(error.localizedDescription)")
								}
							}
						)
						.signInWithAppleButtonStyle(.whiteOutline)
						.frame(height: 56)
						// Divider
						HStack(spacing: 12) {
							Rectangle()
								.fill(Color("TextColor").opacity(0.2))
								.frame(height: 1)
							Text("auth_or")
								.font(.custom("Onest", size: 14))
								.fontWeight(.regular)
								.foregroundColor(Color("TextColor").opacity(0.8))
							Rectangle()
								.fill(Color("TextColor").opacity(0.2))
								.frame(height: 1)
						}
						.padding(.vertical, 8)
						// Email Sign-In Button
						Button(action: {
							withAnimation(.easeInOut(duration: 0.3)) {
								appState.logIn()
							}
						}) {
							HStack(spacing: 12) {
								Image(systemName: "envelope.fill")
									.font(.system(size: 18, weight: .medium))
									.foregroundColor(Color("TextColorInverted"))

								Text("auth_email")
									.font(.custom("Onest", size: 20))
									.fontWeight(.semibold)
									.foregroundColor(Color("TextColorInverted"))
							}
							.frame(maxWidth: .infinity)
							.frame(height: 56)
							.background(
								RoundedRectangle(cornerRadius: 8)
									.fill(Color("AccentColor"))
							)
						}
					}
					.padding(.horizontal, 28)
				}
				Spacer()
				// Privacy & Terms
				Text(.init("auth_terms"))
					.font(.custom("Onest", size: 12))
					.fontWeight(.regular)
					.tint(Color("AccentColor"))
					.foregroundColor(Color("TextColor").opacity(0.6))
					.multilineTextAlignment(.center)
					.padding(.horizontal, 40)
					.padding(.bottom, 20)
					.environment(\.openURL, OpenURLAction { url in
						if url.absoluteString.contains("davidelamarca.com/terms") {
							showTermsSheet = true
							return .handled
						}
						return .systemAction
					})
			}
		}
		.sheet(isPresented: $showTermsSheet) {
			WebViewSheet(url: URL(string: "https://davidelamarca.com/terms")!)
		}
	}
}

#Preview {
	AuthView().environmentObject(AppState())
}
