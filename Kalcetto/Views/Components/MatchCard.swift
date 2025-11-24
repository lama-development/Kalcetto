import SwiftUI

struct MatchCard: View {
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
			VStack(spacing: 0) {
				ZStack(alignment: .topLeading) {
					Image("SoccerFieldGrass")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(height: 110)
						.clipped()
						.overlay(
							Color.black.opacity(0.4)
						)
					VStack(alignment: .leading, spacing: 6) {
						// Match status pill
						HStack {
							if match.isFull {
								Text("match_status_full")
									.font(.system(size: 12, weight: .semibold))
									.foregroundColor(Color("ButtonTextColor"))
									.padding(.horizontal, 10)
									.padding(.vertical, 5)
									.background(
										Capsule()
											.fill(Color.gray)
									)
							} else {
								Text(
									"\(match.spotsLeft) \(match.spotsLeft == 1 ? "posto" : "posti")"
								)
								.font(.system(size: 12, weight: .semibold))
								.foregroundColor(Color("ButtonTextColor"))
								.padding(.horizontal, 10)
								.padding(.vertical, 5)
								.background(
									Capsule()
										.fill(Color("AccentColor"))
								)
							}
							Spacer()
							// Match distance from user
							if let distance = match.distance {
								HStack(spacing: 3) {
									Image(systemName: "location.fill")
										.font(.system(size: 10))
									Text(match.formattedDistance)
										.font(.system(size: 12, weight: .medium))
								}
								.foregroundColor(.white)
								.padding(.horizontal, 10)
								.padding(.vertical, 5)
								.background(
									Capsule()
										.fill(Color.black.opacity(0.3))
								)
							}
						}
						Spacer()
							.frame(height: 8)
						// Match title
						Text(match.title)
							.font(.system(size: 20, weight: .bold))
							.foregroundColor(Color("TextColor"))
							.lineLimit(1)
							.multilineTextAlignment(.leading)
							.shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
					}
					.padding(16)
				}
				.frame(height: 110)
				VStack(alignment: .leading, spacing: 14) {
					HStack(spacing: 8) {
						// Math date and time
						ZStack {
							RoundedRectangle(cornerRadius: 8)
								.fill(Color("TextColor").opacity(0.1))
								.frame(width: 36, height: 36)
							Image(systemName: "calendar")
								.font(.system(size: 16, weight: .semibold))
								.foregroundColor(Color("TextColor"))
						}
						VStack(alignment: .leading, spacing: 2) {
							Text(match.date.formatted(date: .abbreviated, time: .omitted))
								.font(.system(size: 13, weight: .semibold))
								.foregroundColor(Color("TextColor"))
							Text(match.date.formatted(date: .omitted, time: .shortened))
								.font(.system(size: 12, weight: .regular))
								.foregroundColor(Color("TextColor").opacity(0.6))
						}
					}
					HStack(spacing: 8) {
						// Match location
						ZStack {
							RoundedRectangle(cornerRadius: 8)
								.fill(Color("TextColor").opacity(0.1))
								.frame(width: 36, height: 36)
							Image(systemName: "mappin.and.ellipse")
								.font(.system(size: 16, weight: .semibold))
								.foregroundColor(Color("TextColor"))
						}
						VStack(alignment: .leading, spacing: 2) {
							Text(match.location)
								.font(.system(size: 13, weight: .medium))
								.foregroundColor(Color("TextColor"))
								.lineLimit(1)
							Text("Campo di calcio")
								.font(.system(size: 12, weight: .regular))
								.foregroundColor(Color("TextColor").opacity(0.6))
						}
					}
					Divider()
						.background(Color("TextColor").opacity(0.1))
					// Organizer name and profile picture
					HStack {
						HStack(spacing: 6) {
							ZStack {
								Circle()
									.fill(Color("AccentColor").opacity(0.1))
									.frame(width: 24, height: 24)
								Text(String(match.organizerName.prefix(1)).uppercased())
									.font(.system(size: 11, weight: .bold))
									.foregroundColor(Color("AccentColor"))
							}
							Text(match.organizerName)
								.font(.system(size: 12, weight: .medium))
								.foregroundColor(Color("TextColor").opacity(0.7))
								.lineLimit(1)
						}
						Spacer()
						// Player count
						VStack(alignment: .trailing, spacing: 4) {
							HStack(spacing: 4) {
								Image(systemName: "person.2.fill")
									.font(.system(size: 12))
									.foregroundColor(statusColor)
								Text("\(match.currentPlayers)/\(match.maxPlayers)")
									.font(.system(size: 14, weight: .bold))
									.foregroundColor(Color("TextColor"))
							}
							// Progress bar
							GeometryReader { geometry in
								ZStack(alignment: .leading) {
									RoundedRectangle(cornerRadius: 2)
										.fill(Color("TextColor").opacity(0.1))
										.frame(height: 4)
									RoundedRectangle(cornerRadius: 2)
										.fill(statusColor)
										.frame(
											width: geometry.size.width * fillPercentage,
											height: 4
										)
								}
							}
							.frame(width: 60, height: 4)
						}
					}
				}
				.padding(16)
				.background(Color("InputBackgroundColor"))
			}
			.frame(width: 280)
			.clipShape(RoundedRectangle(cornerRadius: 20))
			.overlay(
				RoundedRectangle(cornerRadius: 20)
					.strokeBorder(Color("TextColor").opacity(0.05), lineWidth: 1)
			)
		}
		.buttonStyle(MatchCardButtonStyle())
	}
}

// Custom button style for press animation
struct MatchCardButtonStyle: ButtonStyle {
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
	ScrollView(.horizontal) {
		HStack(spacing: 12) {
			ForEach(Match.mockNearby) { match in
				MatchCard(match: match) {
					print("Match tapped")
				}
			}
		}
		.padding()
	}
	.background(Color("BackgroundColor"))
}
