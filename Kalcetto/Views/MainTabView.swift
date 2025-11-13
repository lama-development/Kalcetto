import SwiftUI

struct MainTabView: View {
	var body: some View {
		TabView {
			Text("Home View")
				.tabItem { Label("home_tab", systemImage: "house") }
			Text("Players View")
				.tabItem { Label("players_tab", systemImage: "soccerball") }
			Text("Fields View")
				.tabItem { Label("map_tab", systemImage: "map") }
			Text("Profile View")
				.tabItem { Label("profile_tab", systemImage: "person") }
		}
	}
}

#Preview {
	MainTabView()
}
