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
					// Illustrated grass texture background
					GrassTextureView()
						.frame(height: 110)

					VStack(alignment: .leading, spacing: 6) {
						// Match status pill
						HStack {
							if match.isFull {
								Text(LocalizedStringKey("match_status_full"))
									.font(.system(size: 12, weight: .bold))
									.foregroundColor(Color.white)
									.padding(.horizontal, 12)
									.padding(.vertical, 6)
									.background(
										Capsule()
											.fill(Color.gray.opacity(0.4))
									)
							} else {
								Text(String(localized: "\(match.spotsLeft) spot(s) available"))
									.font(.system(size: 12, weight: .bold))
									.foregroundColor(Color.white)
									.padding(.horizontal, 12)
									.padding(.vertical, 6)
									.background(
										Capsule()
											.fill(Color.green.opacity(0.4))
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
							.foregroundColor(Color.white)
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
								.fill(Color("BackgroundColor").opacity(0.5))
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
								.fill(Color("BackgroundColor").opacity(0.5))
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
									.fill(Color("AccentColor").opacity(0.1))
									.frame(width: 28, height: 28)
								Text(String(match.organizerName.prefix(1)).uppercased())
									.font(.system(size: 12, weight: .bold))
									.foregroundColor(Color.accentColor)
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
				.background(Color("CardBackgroundColor"))
			}
			.frame(width: 280)
			.clipShape(RoundedRectangle(cornerRadius: 14))
			.overlay(
				RoundedRectangle(cornerRadius: 14)
					.strokeBorder(Color("CardOutlineColor"), lineWidth: 1)
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

// Illustrated grass texture background
struct GrassTextureView: View {
	var body: some View {
		ZStack {
			// Base gradient - rich grass green shades
			LinearGradient(
				colors: [
					Color(red: 0.22, green: 0.6, blue: 0.22),
					Color(red: 0.18, green: 0.52, blue: 0.18),
					Color(red: 0.15, green: 0.48, blue: 0.15),
				],
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)

			// Checkered mowing pattern
			GeometryReader { geometry in
				Canvas { context, size in
					let stripeWidth: CGFloat = 35
					var col = 0
					var x: CGFloat = 0

					while x < size.width {
						let rect = CGRect(
							x: x,
							y: 0,
							width: stripeWidth,
							height: size.height
						)

						// Alternate stripe opacity
						context.fill(
							Path(rect),
							with: .color(
								col % 2 == 0
									? Color.black.opacity(0.12)
									: Color.white.opacity(0.08)
							)
						)

						x += stripeWidth
						col += 1
					}
				}
			}

			// Grass texture overlay with small variations
			GeometryReader { geometry in
				Canvas { context, size in
					// Add small dots/specks for grass texture
					for _ in 0..<150 {
						let x = CGFloat.random(in: 0...size.width)
						let y = CGFloat.random(in: 0...size.height)
						let size = CGFloat.random(in: 1...2)

						let rect = CGRect(x: x, y: y, width: size, height: size)
						context.fill(
							Path(ellipseIn: rect),
							with: .color(Color.black.opacity(Double.random(in: 0.03...0.08)))
						)
					}

					// Add subtle light spots
					for _ in 0..<80 {
						let x = CGFloat.random(in: 0...size.width)
						let y = CGFloat.random(in: 0...size.height)
						let size = CGFloat.random(in: 1...3)

						let rect = CGRect(x: x, y: y, width: size, height: size)
						context.fill(
							Path(ellipseIn: rect),
							with: .color(Color.white.opacity(Double.random(in: 0.05...0.08)))
						)
					}
				}
			}

			// Subtle vignette effect
			RadialGradient(
				colors: [
					Color.clear,
					Color.black.opacity(0.15),
				],
				center: .center,
				startRadius: 50,
				endRadius: 200
			)
		}
	}
}

#Preview {
	ScrollView(.horizontal) {
		HStack(spacing: 12) {
			ForEach(MockData.Matches.nearby) { match in
				MatchCard(match: match) {
					print("Match tapped")
				}
			}
		}
		.padding()
	}
	.background(Color("BackgroundColor"))
}
