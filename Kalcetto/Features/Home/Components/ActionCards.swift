import SwiftUI

struct ActionCards: View {
	let pendingReviews: Int
	let badgesEarned: Int
	let friendsCount: Int
	let onReviewPlayers: () -> Void
	let onViewBadges: () -> Void
	let onViewFriends: () -> Void
	let onExploreFields: () -> Void

	var body: some View {
		VStack(spacing: 12) {
			// Review Players Card (Full width)
			ActionCard(
				icon: "star.fill",
				iconColor: Color.orange,
				title: "review_players_title",
				subtitle: "review_players_subtitle",
				badgeCount: pendingReviews > 0 ? pendingReviews : nil,
				onTap: onReviewPlayers,
				isFullWidth: true
			)

			// Explore Fields Card (Full width)
			ActionCard(
				icon: "map.fill",
				iconColor: Color.green,
				title: "explore_fields_title",
				subtitle: "explore_fields_subtitle",
				onTap: onExploreFields,
				isFullWidth: true
			)

			HStack(spacing: 12) {
				// Badges Card
				ActionCard(
					icon: "trophy.fill",
					iconColor: Color.yellow,
					title: "badges_title",
					value: "\(badgesEarned)",
					onTap: onViewBadges,
					isFullWidth: false
				)

				// Friends Card
				ActionCard(
					icon: "person.2.fill",
					iconColor: Color.blue,
					title: "friends_title",
					value: "\(friendsCount)",
					onTap: onViewFriends,
					isFullWidth: false
				)
			}

		}
	}
}

struct ActionCard: View {
	let icon: String
	let iconColor: Color
	let title: LocalizedStringKey
	var subtitle: LocalizedStringKey?
	var value: String?
	var badgeCount: Int?
	let onTap: () -> Void
	var isFullWidth: Bool = false

	var body: some View {
		Button(action: onTap) {
			if isFullWidth {
				// Full width layout (horizontal)
				HStack(spacing: 12) {
					// Icon
					ZStack {
						Circle()
							.fill(iconColor.opacity(0.1))
							.frame(width: 48, height: 48)
						Image(systemName: icon)
							.font(.system(size: 20, weight: .semibold))
							.foregroundColor(iconColor)
					}

					// Content
					VStack(alignment: .leading, spacing: 4) {
						HStack(spacing: 8) {
							Text(title)
								.font(.system(size: 15, weight: .bold))
								.foregroundColor(Color("TextColor"))

							// Badge indicator
							if let badgeCount = badgeCount, badgeCount > 0 {
								ZStack {
									Circle()
										.fill(Color.red)
										.frame(width: 22, height: 22)
									Text("\(badgeCount)")
										.font(.system(size: 11, weight: .bold))
										.foregroundColor(.white)
								}
							}

							Spacer()
						}

						if let subtitle = subtitle {
							Text(subtitle)
								.font(.system(size: 12, weight: .medium))
								.foregroundColor(Color("TextColor").opacity(0.5))
								.lineLimit(1)
						}
					}

					// Chevron
					Image(systemName: "chevron.right")
						.font(.system(size: 12, weight: .bold))
						.foregroundColor(Color("TextColor").opacity(0.3))
				}
				.padding(14)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(
					RoundedRectangle(cornerRadius: 14)
						.fill(Color("CardBackgroundColor"))
						.overlay(
							RoundedRectangle(cornerRadius: 14)
								.strokeBorder(Color("CardOutlineColor"), lineWidth: 1)
						)
				)
			} else {
				VStack(spacing: 10) {
					// Icon
					ZStack {
						Circle()
							.fill(iconColor.opacity(0.1))
							.frame(width: 44, height: 44)
						Image(systemName: icon)
							.font(.system(size: 18, weight: .semibold))
							.foregroundColor(iconColor)
					}

					// Content
					VStack(alignment: .center, spacing: 4) {
						Text(title)
							.font(.system(size: 13, weight: .bold))
							.foregroundColor(Color("TextColor"))
							.lineLimit(1)

						if let value = value {
							Text(value)
								.font(.system(size: 20, weight: .bold))
								.foregroundColor(iconColor.opacity(0.9))
						}
					}
				}
				.padding(.vertical, 14)
				.padding(.horizontal, 10)
				.frame(maxWidth: .infinity)
				.background(
					RoundedRectangle(cornerRadius: 14)
						.fill(Color("CardBackgroundColor"))
						.overlay(
							RoundedRectangle(cornerRadius: 14)
								.strokeBorder(Color("CardOutlineColor"), lineWidth: 1)
						)
				)
			}
		}
		.buttonStyle(ActionCardButtonStyle())
	}
}

struct ActionCardButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.97 : 1.0)
			.animation(
				.spring(response: 0.3, dampingFraction: 0.7),
				value: configuration.isPressed
			)
	}
}

#Preview {
	ActionCards(
		pendingReviews: 3,
		badgesEarned: 12,
		friendsCount: 48,
		onReviewPlayers: { print("Review players") },
		onViewBadges: { print("View badges") },
		onViewFriends: { print("View friends") },
		onExploreFields: { print("Explore fields") }
	)
	.padding()
	.background(Color("BackgroundColor"))
}
