import AuthenticationServices
import SwiftUI

struct AuthView: View {
	@EnvironmentObject var appState: AppState

	var body: some View {
		ZStack {
			Color("BackgroundColor")
				.ignoresSafeArea()
			VStack(spacing: 16) {
				Image("AppLogo")
					.resizable()
					.scaledToFit()
					.frame(width: 128, height: 128)
					.padding(.top, 32)
				VStack(alignment: .center, spacing: 12) {
					Text("auth_title")
						.font(.largeTitle)
						.bold()
						.foregroundStyle(Color("TextColor"))
					Text("auth_subtitle")
						.font(.body)
						.foregroundStyle(Color("TextColor"))
						.opacity(0.8)
					// MARK: Apple Sign-In
					SignInWithAppleButton(
						.signIn,
						onRequest: { request in
							request.requestedScopes = [.fullName, .email]
						},
						onCompletion: { result in
							switch result {
							case .success(_):
								appState.logIn()
							case .failure(_):
								break
							}
						}
					)
					.signInWithAppleButtonStyle(.whiteOutline)
					.frame(height: 52)
					.padding(.top, 24)
					// MARK: Google Sign-In
					// MARK: Email Sign-In (Mockup)
					Button(action: {
						appState.logIn()
					}) {
						HStack {
							Image(systemName: "envelope.fill")
								.foregroundColor(Color("TextColorInverted"))
							Text("auth_email")
								.font(.title3)
								.foregroundColor(Color("TextColorInverted"))
								.fontWeight(.medium)
						}
						.frame(maxWidth: .infinity)
						.frame(height: 50)
						.background(Color("AccentColor"))
						.cornerRadius(6)
						.overlay(
								RoundedRectangle(cornerRadius: 6)
										.stroke(Color("AccentColor"), lineWidth: 1)
						)
					}
				}
				.padding(.horizontal, 24)
				.safeAreaPadding(.bottom)
				.multilineTextAlignment(.center)
			}
		}
	}
}

#Preview {
	AuthView().environmentObject(AppState())
}
