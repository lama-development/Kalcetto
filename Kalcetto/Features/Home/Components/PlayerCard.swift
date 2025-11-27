import SwiftUI

struct PlayerCard: View {
	let player: Player
	let onTap: () -> Void

	var body: some View {
		Button(action: onTap) {
			HStack(spacing: 16) {
				ZStack {
					Circle()
						.fill(Color("TextColor").opacity(0.08))
						.frame(width: 64, height: 64)
					if let profileImage = player.profileImage {
						Image(systemName: profileImage)
							.resizable()
							.scaledToFit()
							.frame(width: 32, height: 32)
							.foregroundColor(Color("TextColor").opacity(0.8))
					} else {
						Image(systemName: "person.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 32, height: 32)
							.foregroundColor(Color("TextColor").opacity(0.8))
					}
				}
				// Player Info
				VStack(alignment: .leading, spacing: 6) {
					Text(player.name)
						.font(.system(size: 20, weight: .bold))
						.foregroundColor(Color("TextColor"))
					HStack(spacing: 8) {
						// User handle
						Text("@\(player.handle)")
							.font(.system(size: 13, weight: .semibold))
							.foregroundColor(Color("TextColor").opacity(0.6))
						// Reputation score
						HStack(spacing: 4) {
							Image(systemName: "star.fill")
								.font(.system(size: 11, weight: .semibold))
								.foregroundColor(Color.yellow)
							Text(String(format: "%.1f", player.rating))
								.font(.system(size: 13, weight: .semibold))
								.foregroundColor(Color("TextColor").opacity(0.6))
						}
						.padding(.horizontal, 8)
						.padding(.vertical, 4)
						.background(Color.yellow.opacity(0.1))
						.cornerRadius(6)
					}
				}
				Spacer()
				// Chevron
				Image(systemName: "chevron.right")
					.font(.system(size: 12, weight: .semibold))
					.foregroundColor(Color("TextColor").opacity(0.5))
			}
			.padding(16)
		}
		.buttonStyle(PlainButtonStyle())
		.background(
			RoundedRectangle(cornerRadius: 16)
				.fill(Color("CardBackgroundColor"))
				.overlay(
					RoundedRectangle(cornerRadius: 16)
						.stroke(Color("CardOutlineColor"), lineWidth: 1)
				)
		)
	}
}

#Preview {
	PlayerCard(player: Player.mock) {
		print("Card tapped")
	}
	.padding()
	.background(Color("BackgroundColor"))
}
