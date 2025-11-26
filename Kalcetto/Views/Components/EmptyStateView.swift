import SwiftUI

struct EmptyStateView: View {
	let icon: String
	let title: String
	let subtitle: String

	var body: some View {
		VStack(spacing: 20) {
			// Icon with gradient background
			ZStack {
				Circle()
					.fill(
						LinearGradient(
							colors: [
								Color("TextColor").opacity(0.08),
								Color("TextColor").opacity(0.03),
							],
							startPoint: .topLeading,
							endPoint: .bottomTrailing
						)
					)
					.frame(width: 88, height: 88)
				Circle()
					.strokeBorder(Color("TextColor").opacity(0.1), lineWidth: 2)
					.frame(width: 88, height: 88)
				Image(systemName: icon)
					.font(.system(size: 38, weight: .semibold))
					.foregroundColor(Color("TextColor").opacity(0.4))
			}
			.padding(.top, 12)
			// Title and subtitle
			VStack(spacing: 6) {
				Text(title)
					.font(.system(size: 18, weight: .bold))
					.foregroundColor(Color("TextColor"))
					.multilineTextAlignment(.center)
				Text(subtitle)
					.font(.system(size: 14, weight: .medium))
					.foregroundColor(Color("TextColor").opacity(0.5))
					.multilineTextAlignment(.center)
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.vertical, 44)
		.background(
			RoundedRectangle(cornerRadius: 20)
				.fill(Color("CardBackgroundColor"))
				.overlay(
					RoundedRectangle(cornerRadius: 20)
						.strokeBorder(Color("CardOutlineColor"), lineWidth: 1)
				)
		)
	}
}

#Preview {
	VStack(spacing: 20) {
		EmptyStateView(
			icon: "location.slash",
			title: "Nessuna partita nelle vicinanze",
			subtitle: "Prova ad organizzarne una!"
		)

		EmptyStateView(
			icon: "person.2.slash",
			title: "Nessun giocatore trovato",
			subtitle: "Inizia a cercare giocatori"
		)
	}
	.padding()
	.background(Color("BackgroundColor"))
}
