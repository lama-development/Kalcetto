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
									.font(.system(size: 12, weight: .bold))
									.foregroundColor(.white)
									.padding(.horizontal, 12)
									.padding(.vertical, 6)
									.background(
										Capsule()
											.fill(Color.gray.opacity(0.9))
									)
							} else {
								Text(
									"\(match.spotsLeft) \(match.spotsLeft == 1 ? "posto" : "posti")"
								)
								.font(.system(size: 12, weight: .bold))
								.foregroundColor(.white)
								.padding(.horizontal, 12)
								.padding(.vertical, 6)
								.background(
									Capsule()
										.fill(Color.green.opacity(0.95))
								)
							}
							Spacer()
							// Match distance from user
							if let distance = match.distance {
								HStack(spacing: 4) {
									Image(systemName: "location.fill")
										.font(.system(size: 10, weight: .bold))
									Text(match.formattedDistance)
										.font(.system(size: 12, weight: .bold))
								}
								.foregroundColor(.white)
								.padding(.horizontal, 10)
								.padding(.vertical, 6)
								.background(
									Capsule()
										.fill(Color.black.opacity(0.4))
								)
							}
						}
						Spacer()
							.frame(height: 8)
						// Match title
						Text(match.title)
							.font(.system(size: 21, weight: .heavy))
							.foregroundColor(Color("TextColor"))
							.lineLimit(1)
							.multilineTextAlignment(.leading)
							.shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 1)
					}
					.padding(16)
				}
				.frame(height: 110)
				VStack(alignment: .leading, spacing: 14) {
					HStack(spacing: 10) {
						// Math date and time
						ZStack {
							RoundedRectangle(cornerRadius: 10)
								.fill(Color("TextColor").opacity(0.05))
								.frame(width: 40, height: 40)
							Image(systemName: "calendar.badge.clock")
								.font(.system(size: 17, weight: .bold))
								.foregroundColor(Color("TextColor").opacity(0.8))
						}
						VStack(alignment: .leading, spacing: 2) {
							Text(match.date.formatted(date: .abbreviated, time: .omitted))
								.font(.system(size: 14, weight: .bold))
								.foregroundColor(Color("TextColor"))
							Text(
								"\(NSLocalizedString("match_time_prefix", comment: "")) \(match.date.formatted(date: .omitted, time: .shortened))"
							)
							.font(.system(size: 12, weight: .semibold))
							.foregroundColor(Color("TextColor").opacity(0.5))
						}
					}
					HStack(spacing: 10) {
						// Match location
						ZStack {
							RoundedRectangle(cornerRadius: 10)
								.fill(Color("TextColor").opacity(0.05))
								.frame(width: 40, height: 40)
							Image(systemName: "mappin.and.ellipse")
								.font(.system(size: 17, weight: .bold))
								.foregroundColor(Color("TextColor").opacity(0.8))
						}
						VStack(alignment: .leading, spacing: 2) {
							Text(match.location)
								.font(.system(size: 14, weight: .bold))
								.foregroundColor(Color("TextColor"))
								.lineLimit(1)
							Text(match.city)
								.font(.system(size: 12, weight: .semibold))
								.foregroundColor(Color("TextColor").opacity(0.5))
						}
					}
					Divider()
						.background(Color("TextColor").opacity(0.1))
					// Organizer name and profile picture
					HStack {
						HStack(spacing: 8) {
							ZStack {
								Circle()
									.fill(
										LinearGradient(
											colors: [
												Color.accentColor.opacity(0.2),
												Color.accentColor.opacity(0.1),
											],
											startPoint: .topLeading,
											endPoint: .bottomTrailing
										)
									)
									.frame(width: 28, height: 28)
								Text(String(match.organizerName.prefix(1)).uppercased())
									.font(.system(size: 12, weight: .bold))
									.foregroundColor(Color.accentColor.opacity(0.9))
							}
							Text(match.organizerName)
								.font(.system(size: 13, weight: .semibold))
								.foregroundColor(Color("TextColor").opacity(0.7))
								.lineLimit(1)
						}
						Spacer()
						// Player count
						VStack(alignment: .trailing, spacing: 4) {
							HStack(spacing: 5) {
								Image(systemName: "person.2.fill")
									.font(.system(size: 13, weight: .bold))
									.foregroundColor(statusColor)
								Text("\(match.currentPlayers)/\(match.maxPlayers)")
									.font(.system(size: 15, weight: .heavy))
									.foregroundColor(Color("TextColor"))
							}
							// Progress bar
							GeometryReader { geometry in
								ZStack(alignment: .leading) {
									RoundedRectangle(cornerRadius: 3)
										.fill(Color("TextColor").opacity(0.15))
										.frame(height: 6)
									RoundedRectangle(cornerRadius: 3)
										.fill(
											LinearGradient(
												colors: [statusColor, statusColor.opacity(0.7)],
												startPoint: .leading,
												endPoint: .trailing
											)
										)
										.frame(
											width: geometry.size.width * fillPercentage,
											height: 6
										)
								}
							}
							.frame(width: 65, height: 6)
						}
					}
				}
				.padding(16)
				.background(Color("TextColor").opacity(0.05))
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
