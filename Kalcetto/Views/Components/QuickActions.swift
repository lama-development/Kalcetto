import SwiftUI

struct QuickActions: View {
	let onOrganizeMatch: () -> Void
	let onFindMatch: () -> Void

	var body: some View {
		VStack(spacing: 10) {
			Button(action: onOrganizeMatch) {
				HStack(spacing: 14) {
					ZStack {
						Circle()
							.fill(Color("AccentColor").opacity(0.1))
							.frame(width: 48, height: 48)
						Image(systemName: "plus")
							.font(.system(size: 20, weight: .semibold))
							.foregroundColor(Color("AccentColor"))
					}
					VStack(alignment: .leading, spacing: 2) {
						Text("quick_actions_create_title")
							.font(.system(size: 18, weight: .semibold))
							.foregroundColor(Color("TextColor"))
						Text("quick_actions_create_subtitle")
							.font(.system(size: 14, weight: .regular))
							.foregroundColor(Color("TextColor").opacity(0.5))
					}
					Spacer()
					Image(systemName: "chevron.right")
						.font(.system(size: 12, weight: .medium))
						.foregroundColor(Color("TextColor").opacity(0.5))
				}
				.padding(8)
			}
			.buttonStyle(GlassButtonStyle())
			Button(action: onFindMatch) {
				HStack(spacing: 14) {
					ZStack {
						Circle()
							.fill(Color("AccentColor").opacity(0.1))
							.frame(width: 48, height: 48)
						Image(systemName: "magnifyingglass")
							.font(.system(size: 18, weight: .semibold))
							.foregroundColor(Color("AccentColor"))
					}
					VStack(alignment: .leading, spacing: 2) {
						Text("quick_actions_search_title")
							.font(.system(size: 18, weight: .semibold))
							.foregroundColor(Color("TextColor"))
						Text("quick_actions_search_subtitle")
							.font(.system(size: 14, weight: .regular))
							.foregroundColor(Color("TextColor").opacity(0.5))
					}
					Spacer()
					Image(systemName: "chevron.right")
						.font(.system(size: 12, weight: .medium))
						.foregroundColor(Color("TextColor").opacity(0.5))
				}
				.padding(8)
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
