import SwiftUI

struct PlayerStatsCard: View {
	let player: Player

	var body: some View {
		VStack(spacing: 0) {
			// Header
			HStack {
				HStack(spacing: 6) {
					Image(systemName: "chart.bar.fill")
						.font(.system(size: 14, weight: .semibold))
						.foregroundColor(Color.accentColor)
					Text("Performance")
						.font(.system(size: 16, weight: .bold))
						.foregroundColor(Color("TextColor"))
				}
				Spacer()
			}
			.padding(.horizontal, 16)
			.padding(.top, 16)
			.padding(.bottom, 12)

			// Stats Grid
			HStack(spacing: 12) {
				// Matches Played
				StatBox(
					icon: "figure.run",
					value: "\(player.matchesPlayed)",
					label: "Matches",
					accentColor: Color.blue
				)

				// Win Rate
				StatBox(
					icon: "chart.line.uptrend.xyaxis",
					value: String(format: "%.0f%%", player.winRate),
					label: "Win Rate",
					accentColor: Color.green
				)

				// Record
				StatBox(
					icon: "list.bullet.clipboard",
					value: "\(player.matchesWon)-\(player.matchesLost)",
					label: "W-L",
					accentColor: Color.orange
				)
			}
			.padding(.horizontal, 16)
			.padding(.bottom, 16)
		}
		.background(
			RoundedRectangle(cornerRadius: 16)
				.fill(Color("TextColor").opacity(0.05))
				.overlay(
					RoundedRectangle(cornerRadius: 16)
						.stroke(Color("TextColor").opacity(0.1), lineWidth: 1)
				)
		)
	}
}

struct StatBox: View {
	let icon: String
	let value: String
	let label: String
	let accentColor: Color

	var body: some View {
		VStack(spacing: 8) {
			// Icon with colored background
			ZStack {
				Circle()
					.fill(accentColor.opacity(0.15))
					.frame(width: 44, height: 44)
				Image(systemName: icon)
					.font(.system(size: 18, weight: .semibold))
					.foregroundColor(accentColor.opacity(0.9))
			}

			// Value
			Text(value)
				.font(.system(size: 20, weight: .bold))
				.foregroundColor(Color("TextColor"))

			// Label
			Text(label)
				.font(.system(size: 11, weight: .medium))
				.foregroundColor(Color("TextColor").opacity(0.5))
				.lineLimit(1)
		}
		.frame(maxWidth: .infinity)
		.padding(.vertical, 12)
		.background(
			RoundedRectangle(cornerRadius: 12)
				.fill(Color("TextColor").opacity(0.03))
		)
	}
}

#Preview {
	PlayerStatsCard(player: Player.mock)
		.padding()
		.background(Color("BackgroundColor"))
}
