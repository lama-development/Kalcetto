import SwiftUI

struct EmptyStateView: View {
	let icon: String
	let title: String
	let subtitle: String

	var body: some View {
		VStack(spacing: 16) {
			// Icon with circular background
			ZStack {
				Circle()
					.fill(Color("TextColor").opacity(0.1))
					.frame(width: 80, height: 80)
				Image(systemName: icon)
					.font(.system(size: 36, weight: .medium))
					.foregroundColor(Color("TextColor").opacity(0.6))
			}
			.padding(.top, 8)
			// Title and subtitle
			VStack(spacing: 8) {
				Text(title)
					.font(.system(size: 18, weight: .semibold))
					.foregroundColor(Color("TextColor"))
					.multilineTextAlignment(.center)
				Text(subtitle)
					.font(.system(size: 15, weight: .regular))
					.foregroundColor(Color("TextColor").opacity(0.6))
					.multilineTextAlignment(.center)
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.vertical, 40)
		.background(
			RoundedRectangle(cornerRadius: 24)
				.fill(Color("InputBackgroundColor"))
				.overlay(
					RoundedRectangle(cornerRadius: 24)
						.strokeBorder(Color("TextColor").opacity(0.05), lineWidth: 1)
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
