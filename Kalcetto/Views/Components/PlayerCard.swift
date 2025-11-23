//
//  PlayerCard.swift
//  Kalcetto
//

import SwiftUI

struct PlayerCard: View {
	let player: Player
	let onTap: () -> Void

	var body: some View {
		Button(action: onTap) {
			HStack(spacing: 20) {
				// Profile Image
				ZStack {
					Circle()
						.fill(Color("TextColor").opacity(0.06))
						.frame(width: 64, height: 64)

					if let profileImage = player.profileImage {
						Image(systemName: profileImage)
							.resizable()
							.scaledToFit()
							.frame(width: 32, height: 32)
							.foregroundColor(Color("TextColor").opacity(0.6))
					} else {
						Image(systemName: "person.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 32, height: 32)
							.foregroundColor(Color("TextColor").opacity(0.6))
					}
				}

				// Player Info
				VStack(alignment: .leading, spacing: 4) {
					Text(player.name)
						.font(.system(size: 22, weight: .semibold))
						.foregroundColor(Color("TextColor"))

					HStack(spacing: 6) {
						Text(player.level.name)
							.font(.system(size: 15, weight: .regular))
							.foregroundColor(Color("TextColor").opacity(0.5))

						Circle()
							.fill(Color("TextColor").opacity(0.3))
							.frame(width: 3, height: 3)

						Text("\(player.points) pts")
							.font(.system(size: 15, weight: .regular))
							.foregroundColor(Color("TextColor").opacity(0.5))
					}
				}

				Spacer()

				Image(systemName: "chevron.right")
					.font(.system(size: 13, weight: .medium))
					.foregroundColor(Color("TextColor").opacity(0.2))
			}
			.padding(20)
			.background(
				RoundedRectangle(cornerRadius: 48)
					.fill(Color("InputBackgroundColor"))
			)
		}
		.buttonStyle(PlainButtonStyle())
	}
}

#Preview {
	PlayerCard(player: Player.mock) {
		print("Card tapped")
	}
	.padding()
	.background(Color("BackgroundColor"))
}
