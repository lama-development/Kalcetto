import SwiftUI

struct MatchListItem: View {
	let match: Match
	let onTap: () -> Void

	private var statusColor: Color {
		match.isFull ? Color.gray : Color("AccentColor")
	}

	private var fillPercentage: Double {
		Double(match.currentPlayers) / Double(match.maxPlayers)
	}

	var body: some View {
		Button(action: onTap) {
			HStack(spacing: 14) {
				// Left side - Date indicator
				VStack(spacing: 4) {
					Text(match.date.formatted(.dateTime.day()))
						.font(.system(size: 24, weight: .heavy))
						.foregroundColor(Color("TextColor"))
					Text(match.date.formatted(.dateTime.month(.abbreviated)))
						.font(.system(size: 11, weight: .bold))
						.foregroundColor(Color("TextColor").opacity(0.5))
						.textCase(.uppercase)
				}
				.frame(width: 50)
				.padding(.vertical, 12)
				.background(
					RoundedRectangle(cornerRadius: 12)
						.fill(Color("BackgroundColor").opacity(0.5))
				)

				// Main content
				VStack(alignment: .leading, spacing: 10) {
					// Title and status
					HStack(alignment: .top) {
						Text(match.title)
							.font(.system(size: 16, weight: .bold))
							.foregroundColor(Color("TextColor"))
							.lineLimit(1)
						Spacer()
						if match.isFull {
							Text(LocalizedStringKey("match_status_full"))
								.font(.system(size: 10, weight: .bold))
								.foregroundColor(Color("ButtonTextColor"))
								.padding(.horizontal, 8)
								.padding(.vertical, 4)
								.background(
									Capsule()
										.fill(Color.gray)
								)
						} else {
							Text(String(localized: "\(match.spotsLeft) spot(s) available"))
								.font(.system(size: 10, weight: .bold))
								.foregroundColor(Color("ButtonTextColor"))
								.padding(.horizontal, 8)
								.padding(.vertical, 4)
								.background(
									Capsule()
										.fill(Color.green)
								)
						}
					}

					// Time and location
					HStack(spacing: 12) {
						HStack(spacing: 3) {
							Image(systemName: "clock.fill")
								.font(.system(size: 11, weight: .semibold))
								.foregroundColor(Color("TextColor").opacity(0.5))
							Text(match.date.formatted(date: .omitted, time: .shortened))
								.font(.system(size: 13, weight: .semibold))
								.foregroundColor(Color("TextColor").opacity(0.6))
						}

						HStack(spacing: 3) {
							Image(systemName: "location.fill")
								.font(.system(size: 11, weight: .semibold))
								.foregroundColor(Color("TextColor").opacity(0.5))
							Text(match.location)
								.font(.system(size: 13, weight: .semibold))
								.foregroundColor(Color("TextColor").opacity(0.5))
								.lineLimit(1)
						}
					}

					// Player count and progress
					HStack {
						HStack(spacing: 5) {
							Image(systemName: "person.2.fill")
								.font(.system(size: 11, weight: .bold))
								.foregroundColor(statusColor)
							Text("\(match.currentPlayers)/\(match.maxPlayers)")
								.font(.system(size: 13, weight: .bold))
								.foregroundColor(Color("TextColor"))
						}

						// Progress bar
						GeometryReader { geometry in
							ZStack(alignment: .leading) {
								RoundedRectangle(cornerRadius: 2.5)
									.fill(Color("TextColor").opacity(0.12))
									.frame(height: 5)
								RoundedRectangle(cornerRadius: 2.5)
									.fill(
										LinearGradient(
											colors: [statusColor, statusColor.opacity(0.7)],
											startPoint: .leading,
											endPoint: .trailing
										)
									)
									.frame(
										width: geometry.size.width * fillPercentage,
										height: 5
									)
							}
						}
						.frame(height: 5)
					}
				}
				.padding(.vertical, 4)
			}
			.padding(14)
			.background(
				RoundedRectangle(cornerRadius: 14)
					.fill(Color("CardBackgroundColor"))
					.overlay(
						RoundedRectangle(cornerRadius: 14)
							.strokeBorder(Color("CardOutlineColor"), lineWidth: 1)
					)
			)
		}
		.buttonStyle(MatchListItemButtonStyle())
	}
}

// Custom button style for press animation
struct MatchListItemButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
			.animation(
				.spring(response: 0.3, dampingFraction: 0.7),
				value: configuration.isPressed
			)
	}
}

#Preview {
	VStack(spacing: 12) {
		ForEach(MockData.Matches.myMatches) { match in
			MatchListItem(match: match) {
				print("Match tapped")
			}
		}
	}
	.padding()
	.background(Color("BackgroundColor"))
}
