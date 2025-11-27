import MapKit
import SwiftUI

struct MatchDetailSheet: View {
	let match: Match
	@Environment(\.dismiss) private var dismiss

	var body: some View {
		ZStack(alignment: .topTrailing) {
			ScrollView(showsIndicators: false) {
				VStack(spacing: 0) {
					// Header
					ZStack(alignment: .topLeading) {
						GrassTextureView()
							.frame(height: 160)
						VStack(alignment: .leading, spacing: 8) {
							Spacer()

							// Match title
							Text(match.title)
								.font(.system(size: 26, weight: .heavy))
								.foregroundColor(Color.white)
								.lineLimit(2)
								.shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 1)

							// Status badge and distance
							HStack(spacing: 8) {
								if match.isFull {
									Text(LocalizedStringKey("match_status_full"))
										.font(.system(size: 13, weight: .bold))
										.foregroundColor(Color.white)
										.padding(.horizontal, 14)
										.padding(.vertical, 7)
										.background(
											Capsule()
												.fill(Color.gray.opacity(0.5))
										)
								} else {
									Text(
										String(localized: "\(match.spotsLeft) spot(s) available")
									)
									.font(.system(size: 13, weight: .bold))
									.foregroundColor(Color.white)
									.padding(.horizontal, 10)
									.padding(.vertical, 6)
									.background(
										Capsule()
											.fill(Color.green.opacity(0.5))
									)
								}

								if let distance = match.distance {
									HStack(spacing: 3) {
										Image(systemName: "location.fill")
											.font(.system(size: 11, weight: .semibold))
										Text(match.formattedDistance)
											.font(.system(size: 13, weight: .bold))
									}
									.foregroundColor(Color.white)
									.padding(.horizontal, 10)
									.padding(.vertical, 6)
									.background(
										Capsule()
											.fill(Color.black.opacity(0.4))
									)
								}

								Spacer()
							}
						}
						.padding(20)
					}
					.frame(height: 160)

					VStack(alignment: .leading, spacing: 12) {
						// Date and time - Card
						VStack(alignment: .leading, spacing: 10) {
							HStack(spacing: 10) {
								ZStack {
									RoundedRectangle(cornerRadius: 10)
										.fill(Color("BackgroundColor").opacity(0.5))
										.frame(width: 40, height: 40)
									Image(systemName: "calendar.badge.clock")
										.font(.system(size: 17, weight: .bold))
										.foregroundColor(Color("TextColor").opacity(0.8))
								}
								VStack(alignment: .leading, spacing: 2) {
									Text(match.date.formatted(date: .long, time: .omitted))
										.font(.system(size: 15, weight: .bold))
										.foregroundColor(Color("TextColor"))
									Text(
										"\(NSLocalizedString("match_time_prefix", comment: "")) \(match.date.formatted(date: .omitted, time: .shortened))"
									)
									.font(.system(size: 13, weight: .medium))
									.foregroundColor(Color("TextColor").opacity(0.5))
								}
								Spacer()
							}
							.padding(14)
						}
						.background(
							RoundedRectangle(cornerRadius: 14)
								.fill(Color("CardBackgroundColor"))
								.overlay(
									RoundedRectangle(cornerRadius: 14)
										.strokeBorder(Color("CardOutlineColor"), lineWidth: 1)
								)
						)

						// Location - Card
						VStack(alignment: .leading, spacing: 10) {
							HStack(spacing: 10) {
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
										.font(.system(size: 15, weight: .bold))
										.foregroundColor(Color("TextColor"))
									Text(match.city)
										.font(.system(size: 13, weight: .medium))
										.foregroundColor(Color("TextColor").opacity(0.5))
								}
								Spacer()

								// Open in Maps button
								if match.latitude != nil && match.longitude != nil {
									Button(action: openInMaps) {
										Image(systemName: "map.fill")
											.font(.system(size: 16, weight: .bold))
											.foregroundColor(Color("TextColor"))
											.padding(.vertical, 5)
									}
									.buttonStyle(GlassButtonStyle())
								}
							}
							.padding(14)
						}
						.background(
							RoundedRectangle(cornerRadius: 14)
								.fill(Color("CardBackgroundColor"))
								.overlay(
									RoundedRectangle(cornerRadius: 14)
										.strokeBorder(Color("CardOutlineColor"), lineWidth: 1)
								)
						)

						// Players - Card
						VStack(alignment: .leading, spacing: 12) {
							HStack(spacing: 10) {
								ZStack {
									RoundedRectangle(cornerRadius: 10)
										.fill(Color("BackgroundColor").opacity(0.5))
										.frame(width: 40, height: 40)
									Image(systemName: "person.2.fill")
										.font(.system(size: 17, weight: .bold))
										.foregroundColor(Color("TextColor").opacity(0.8))
								}
								VStack(alignment: .leading, spacing: 2) {
									Text("\(match.actualCurrentPlayers)/\(match.maxPlayers)")
										.font(.system(size: 15, weight: .bold))
										.foregroundColor(Color("TextColor"))
									Text("match_detail_players_registered")
										.font(.system(size: 13, weight: .medium))
										.foregroundColor(Color("TextColor").opacity(0.5))
								}
								Spacer()
							}

							Divider()
								.background(Color("CardOutlineColor"))

							// Players list (organizer first)
							VStack(spacing: 8) {
								// Organizer as first player
								Button(action: {
									viewPlayer(organizerName: match.organizerName)
								}) {
									HStack(spacing: 10) {
										ZStack {
											Circle()
												.fill(Color("AccentColor").opacity(0.1))
												.frame(width: 36, height: 36)
											Text(String(match.organizerName.prefix(1)).uppercased())
												.font(.system(size: 14, weight: .bold))
												.foregroundColor(Color.accentColor)
										}
										VStack(alignment: .leading, spacing: 2) {
											HStack(spacing: 6) {
												Text(match.organizerName)
													.font(.system(size: 14, weight: .semibold))
													.foregroundColor(Color("TextColor"))
												Text("match_detail_organizer_badge")
													.font(.system(size: 10, weight: .bold))
													.foregroundColor(Color("AccentColor"))
													.padding(.horizontal, 6)
													.padding(.vertical, 2)
													.background(
														Capsule()
															.fill(Color("AccentColor").opacity(0.15))
													)
											}
											HStack(spacing: 6) {
												Text("@\(match.organizerHandle)")
													.font(.system(size: 12, weight: .medium))
													.foregroundColor(Color("TextColor").opacity(0.5))
												HStack(spacing: 3) {
													Image(systemName: "star.fill")
														.font(.system(size: 10, weight: .semibold))
														.foregroundColor(Color.yellow)
													Text(String(format: "%.1f", match.organizerRating))
														.font(.system(size: 12, weight: .medium))
														.foregroundColor(Color("TextColor").opacity(0.5))
												}
											}
										}
										Spacer()
										Image(systemName: "chevron.right")
											.font(.system(size: 12, weight: .bold))
											.foregroundColor(Color("TextColor").opacity(0.3))
									}
									.padding(.vertical, 4)
								}
								.buttonStyle(PlayerCardButtonStyle())

								// Other players
								if let players = match.players, !players.isEmpty {
									ForEach(players) { player in
										Button(action: { viewPlayer(player: player) }) {
											HStack(spacing: 10) {
												ZStack {
													Circle()
														.fill(Color("AccentColor").opacity(0.1))
														.frame(width: 36, height: 36)
													Text(String(player.name.prefix(1)).uppercased())
														.font(.system(size: 14, weight: .bold))
														.foregroundColor(Color.accentColor)
												}
												VStack(alignment: .leading, spacing: 2) {
													Text(player.name)
														.font(.system(size: 14, weight: .semibold))
														.foregroundColor(Color("TextColor"))
													HStack(spacing: 6) {
														Text("@\(player.handle)")
															.font(.system(size: 12, weight: .medium))
															.foregroundColor(Color("TextColor").opacity(0.5))
														HStack(spacing: 3) {
															Image(systemName: "star.fill")
																.font(.system(size: 10, weight: .semibold))
																.foregroundColor(Color.yellow)
															Text(String(format: "%.1f", player.rating))
																.font(.system(size: 12, weight: .medium))
																.foregroundColor(
																	Color("TextColor").opacity(0.5)
																)
														}
													}
												}
												Spacer()

												Image(systemName: "chevron.right")
													.font(.system(size: 12, weight: .bold))
													.foregroundColor(Color("TextColor").opacity(0.3))
											}
											.padding(.vertical, 4)
										}
										.buttonStyle(PlayerCardButtonStyle())
									}
								}
							}
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
					.padding(.horizontal, 20)
					.padding(.top, 30)
					.padding(.bottom, 160)
				}
			}
			.background(Color("BackgroundColor").ignoresSafeArea())

			// Floating CTA buttons at bottom
			VStack {
				Spacer()

				VStack(spacing: 10) {
					if !match.isFull {
						Button(action: joinMatch) {
							HStack(spacing: 8) {
								Image(systemName: "paperplane.fill")
									.font(.system(size: 15, weight: .bold))
								Text("match_detail_join")
									.font(.system(size: 17, weight: .bold))
							}
							.foregroundColor(Color("ButtonTextColor"))
							.frame(maxWidth: .infinity)
							.padding(.vertical, 12)
						}
						.buttonStyle(GlassProminentButtonStyle())
					}

					Button(action: shareMatch) {
						HStack(spacing: 8) {
							Image(systemName: "square.and.arrow.up")
								.font(.system(size: 15, weight: .bold))
							Text("match_detail_share")
								.font(.system(size: 17, weight: .bold))
						}
						.foregroundColor(Color("TextColor").opacity(0.7))
						.frame(maxWidth: .infinity)
						.padding(.vertical, 12)
					}
					.buttonStyle(GlassButtonStyle())
				}
				.padding(.horizontal, 20)
				.padding(.bottom, 10)
				.padding(.top, 10)
				.background(
					LinearGradient(
						gradient: Gradient(colors: [
							Color("BackgroundColor").opacity(0),
							Color("BackgroundColor"),
						]),
						startPoint: .top,
						endPoint: .bottom
					)
					.ignoresSafeArea()
				)
			}

			// Close button overlayed
			Button(action: { dismiss() }) {
				Image(systemName: "xmark")
					.font(.system(size: 18, weight: .semibold))
					.foregroundColor(Color.gray)
					.padding(.vertical, 5)
			}
			.buttonStyle(GlassButtonStyle())
			.padding(.top, 20)
			.padding(.trailing, 20)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
		}
	}

	private func openInMaps() {
		guard let latitude = match.latitude, let longitude = match.longitude else {
			return
		}

		let coordinate = CLLocationCoordinate2D(
			latitude: latitude,
			longitude: longitude
		)
		let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
		mapItem.name = match.location
		mapItem.openInMaps(launchOptions: [
			MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
		])
	}

	private func joinMatch() {
		// TODO: Implement join match logic
		print("Join match: \(match.title)")
	}

	private func shareMatch() {
		// TODO: Implement share match logic
		print("Share match: \(match.title)")
	}

	private func viewPlayer(player: Player) {
		// TODO: Navigate to player profile
		print("View player: \(player.name)")
	}

	private func viewPlayer(organizerName: String) {
		// TODO: Navigate to organizer profile
		print("View organizer: \(organizerName)")
	}
}

// Custom button style for player cards
struct PlayerCardButtonStyle: ButtonStyle {
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
	MatchDetailSheet(match: MockData.Matches.nearby[0])
}
