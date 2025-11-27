import SwiftUI

struct QuickActions: View {
	let onOrganizeMatch: () -> Void
	let onFindMatch: () -> Void

	var body: some View {
		VStack(spacing: 12) {
			Button(action: onOrganizeMatch) {
				HStack(spacing: 14) {
					ZStack {
						Circle()
							.fill(Color("AccentColor").opacity(0.1))
							.frame(width: 48, height: 48)
						Image(systemName: "plus")
							.font(.system(size: 22, weight: .bold))
							.foregroundColor(Color("AccentColor"))
					}
					VStack(alignment: .leading, spacing: 4) {
						Text("quick_actions_create_title")
							.font(.system(size: 17, weight: .bold))
							.foregroundColor(Color("TextColor"))
						Text("quick_actions_create_subtitle")
							.font(.system(size: 13, weight: .medium))
							.foregroundColor(Color("TextColor").opacity(0.6))
					}
					Spacer()
					Image(systemName: "chevron.right")
						.font(.system(size: 13, weight: .semibold))
						.foregroundColor(Color("TextColor").opacity(0.4))
				}
				.padding(12)
			}
			.buttonStyle(GlassButtonStyle())
			Button(action: onFindMatch) {
				HStack(spacing: 14) {
					ZStack {
						Circle()
							.fill(Color("AccentColor").opacity(0.1))
							.frame(width: 48, height: 48)
						Image(systemName: "magnifyingglass")
							.font(.system(size: 20, weight: .bold))
							.foregroundColor(Color("AccentColor"))
					}
					VStack(alignment: .leading, spacing: 4) {
						Text("quick_actions_search_title")
							.font(.system(size: 17, weight: .bold))
							.foregroundColor(Color("TextColor"))
						Text("quick_actions_search_subtitle")
							.font(.system(size: 13, weight: .medium))
							.foregroundColor(Color("TextColor").opacity(0.6))
					}
					Spacer()
					Image(systemName: "chevron.right")
						.font(.system(size: 13, weight: .semibold))
						.foregroundColor(Color("TextColor").opacity(0.4))
				}
				.padding(12)
			}
			.buttonStyle(GlassButtonStyle())
		}
	}
}

#Preview {
	QuickActions(
		onOrganizeMatch: { print("Organize") },
		onFindMatch: { print("Find") }
	)
	.padding()
	.background(Color("BackgroundColor"))
}
