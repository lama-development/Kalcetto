import SwiftUI

struct MainTabView: View {
	@State private var selectedTab = 0

	var body: some View {
		TabView(selection: $selectedTab) {
			// Home tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()
					VStack(spacing: 20) {
						HomeView()
					}
				}
			}
			.tabItem {
				Label("home_tab", systemImage: "house")
			}
			.tag(0)
			// Matches tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()
					VStack(spacing: 20) {
					}
				}
				.navigationTitle("matches_tab")
			}
			.tabItem {
				Label("matches_tab", systemImage: "sportscourt")
			}
			.tag(1)
			// Players tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()
					VStack(spacing: 20) {
					}
				}
				.navigationTitle("players_tab")
			}
			.tabItem {
				Label("players_tab", systemImage: "soccerball")
			}
			.tag(2)
			// Profile tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()
					VStack(spacing: 20) {
					}
				}
				.navigationTitle("profile_tab")
			}
			.tabItem {
				Label("profile_tab", systemImage: "person")
			}
			.tag(3)
		}
		.tint(Color.green)
	}
}

#Preview {
	MainTabView()
}
