import SwiftUI

@main
struct KalcettoApp: App {
	@StateObject private var appState = AppState()

	var body: some Scene {
		WindowGroup {
			RootView()
				.environmentObject(appState)
		}
	}
}
