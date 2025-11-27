import SwiftUI

struct PlayerStatsCard: View {
	let player: Player

	var body: some View {
		VStack(spacing: 0) {

			// Stats Grid
			HStack(spacing: 12) {
				// Matches Played
				StatBox(
					icon: "figure.indoor.soccer",
					value: "\(player.matchesPlayed)",
					label: "stats_match_played",
					accentColor: Color.blue
				)

				// Win Rate
				StatBox(
					icon: "chart.line.uptrend.xyaxis",
					value: String(format: "%.0f%%", player.winRate),
					label: "stats_win_rate",
					accentColor: Color.purple
				)

				// Record
				StatBox(
					icon: "arrow.up.arrow.down",
					value: "\(player.matchesWon)-\(player.matchesLost)",
					label: "stats_win_loss",
					accentColor: Color.orange
				)
			}
			.padding(16)
		}
		.background(
			RoundedRectangle(cornerRadius: 14)
				.fill(Color("CardBackgroundColor"))
				.overlay(
					RoundedRectangle(cornerRadius: 14)
						.stroke(Color("CardOutlineColor"), lineWidth: 1)
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
					.fill(accentColor.opacity(0.1))
					.frame(width: 44, height: 44)
				Image(systemName: icon)
					.font(.system(size: 18, weight: .semibold))
					.foregroundColor(accentColor)
			}

			// Value
			Text(value)
				.font(.system(size: 20, weight: .bold))
				.foregroundColor(Color("TextColor"))

			// Label
			Text(LocalizedStringKey(label))
				.font(.system(size: 11, weight: .medium))
				.foregroundColor(Color("TextColor").opacity(0.5))
				.lineLimit(1)
		}
		.frame(maxWidth: .infinity)
		.padding(.vertical, 12)
		.background(
			RoundedRectangle(cornerRadius: 12)
				.fill(Color("BackgroundColor").opacity(0.5))
		)
	}
}

#Preview {
	PlayerStatsCard(player: MockData.Players.currentUser)
		.padding()
		.background(Color("BackgroundColor"))
}
