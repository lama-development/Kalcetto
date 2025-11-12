import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // Solid background
            Color(.accent)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                // App logo
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                    .padding(.top, 32)
                
                // Bottom content: title, description, buttons
							VStack(alignment: .center, spacing: 12) {
                    Text("auth_title")
                        .font(.largeTitle)
                        .bold()
												.foregroundStyle(.black)
                    Text("auth_subtitle")
                        .font(.body)
												.foregroundStyle(Color.black)
												.opacity(0.8)
                    // MARK: Apple Sign-In
                    SignInWithAppleButton(.signIn, onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    }, onCompletion: { result in
                        switch result {
                        case .success(_):
                            appState.logIn()
                        case .failure(_):
                            break
                        }
                    })
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 52)
										.padding(.top, 12)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    // MARK: Google Sign-In
                }
                .padding(.horizontal, 24)
                .safeAreaPadding(.bottom)
                .padding(.bottom, 56)
								.multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    AuthView().environmentObject(AppState())
}
