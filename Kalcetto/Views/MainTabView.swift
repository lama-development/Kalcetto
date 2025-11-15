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
						Image(systemName: "house.fill")
							.font(.system(size: 60))
							.foregroundColor(Color("AccentColor").opacity(0.3))

						Text("Home View")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color("TextColor"))

						Text("Benvenuto su Kalcetto")
							.font(.system(size: 16))
							.foregroundColor(Color("TextColor").opacity(0.6))
					}
				}
				.navigationTitle("home_tab")
			}
			.tabItem {
				Label(
					"home_tab",
					systemImage: selectedTab == 0 ? "house.fill" : "house"
				)
			}
			.tag(0)

			// Players Tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()

					VStack(spacing: 20) {
						Image(systemName: "person.3.fill")
							.font(.system(size: 60))
							.foregroundColor(Color("AccentColor").opacity(0.3))

						Text("Players View")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color("TextColor"))

						Text("Trova giocatori vicino a te")
							.font(.system(size: 16))
							.foregroundColor(Color("TextColor").opacity(0.6))
					}
				}
				.navigationTitle("players_tab")
			}
			.tabItem {
				Label(
					"players_tab",
					systemImage: selectedTab == 1 ? "person.3.fill" : "person.3"
				)
			}
			.tag(1)

			// Map/Fields Tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()

					VStack(spacing: 20) {
						Image(systemName: "map.fill")
							.font(.system(size: 60))
							.foregroundColor(Color("AccentColor").opacity(0.3))

						Text("Fields View")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color("TextColor"))

						Text("Esplora campi nelle vicinanze")
							.font(.system(size: 16))
							.foregroundColor(Color("TextColor").opacity(0.6))
					}
				}
				.navigationTitle("map_tab")
			}
			.tabItem {
				Label("map_tab", systemImage: selectedTab == 2 ? "map.fill" : "map")
			}
			.tag(2)

			// Profile Tab
			NavigationStack {
				ZStack {
					Color("BackgroundColor")
						.ignoresSafeArea()

					VStack(spacing: 20) {
						Image(systemName: "person.circle.fill")
							.font(.system(size: 60))
							.foregroundColor(Color("AccentColor").opacity(0.3))

						Text("Profile View")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color("TextColor"))

						Text("Il tuo profilo e impostazioni")
							.font(.system(size: 16))
							.foregroundColor(Color("TextColor").opacity(0.6))
					}
				}
				.navigationTitle("profile_tab")
			}
			.tabItem {
				Label(
					"profile_tab",
					systemImage: selectedTab == 3 ? "person.fill" : "person"
				)
			}
			.tag(3)
		}
		.tint(Color("AccentColor"))
	}
}

#Preview {
	MainTabView()
}
