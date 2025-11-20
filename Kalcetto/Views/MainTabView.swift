import SwiftUI

struct MainTabView: View {
	@State private var selectedTab = 0

	var body: some View {
		TabView(selection: $selectedTab) {
			// Home Tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()
					VStack(spacing: 20) {
					}
				}
				.navigationTitle("home_tab")
			}
			.tabItem {
				Label("home_tab", systemImage: "house.fill")
			}
			.tag(0)

			// Players Tab
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
			.tag(1)

			// Map/Fields Tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()
					VStack(spacing: 20) {
					}
				}
				.navigationTitle("map_tab")
			}
			.tabItem {
				Label("map_tab", systemImage: "map")
			}
			.tag(2)

			// Profile Tab
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
		.tint(Color("AccentColor"))
	}
}

#Preview {
	MainTabView()
}
