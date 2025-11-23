import SwiftUI

struct HomeView: View {
	@StateObject private var viewModel = HomeViewModel()

	var body: some View {
		NavigationView {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 24) {
					// Quick Actions
					VStack(alignment: .leading, spacing: 12) {
						QuickActions(
							onOrganizeMatch: viewModel.organizeMatch,
							onFindMatch: viewModel.findMatch
						)
					}
					.padding(.horizontal, 20)

					// Nearby Matches Section
					VStack(alignment: .leading, spacing: 16) {
						HStack {
							Text("Partite vicine")
								.font(.system(size: 24, weight: .semibold))
								.foregroundColor(Color("TextColor"))

							Spacer()

							Button(action: viewModel.viewAllNearbyMatches) {
								HStack(spacing: 4) {
									Text("Mostra tutto")
										.font(.system(size: 15, weight: .medium))
									Image(systemName: "chevron.right")
										.font(.system(size: 12, weight: .medium))
								}
								.foregroundColor(Color("TextColor").opacity(0.5))
							}
						}
						.padding(.horizontal, 20)

						if viewModel.nearbyMatches.isEmpty {
							EmptyStateView(
								icon: "location.slash",
								title: "Nessuna partita nelle vicinanze",
								subtitle: "Prova ad organizzarne una!"
							)
							.padding(.horizontal, 20)
						} else {
							ScrollView(.horizontal, showsIndicators: false) {
								HStack(spacing: 12) {
									ForEach(viewModel.nearbyMatches) { match in
										MatchCard(match: match) {
											viewModel.selectMatch(match)
										}
									}
								}
								.padding(.horizontal, 20)
							}
						}
					}

					Spacer(minLength: 20)
				}
				.padding(.top, 20)
				.padding(.bottom, 30)
			}
			.navigationTitle("home_tab")
			.background(Color("BackgroundColor").ignoresSafeArea())
			.navigationBarTitleDisplayMode(.large)
		}
		.onAppear {
			viewModel.loadData()
		}
	}
}

struct EmptyStateView: View {
	let icon: String
	let title: String
	let subtitle: String

	var body: some View {
		VStack(spacing: 12) {
			Image(systemName: icon)
				.font(.system(size: 40))
				.foregroundColor(Color("TextColor").opacity(0.2))

			Text(title)
				.font(.system(size: 16, weight: .medium))
				.foregroundColor(Color("TextColor").opacity(0.5))
		}
		.frame(maxWidth: .infinity)
		.padding(.vertical, 50)
		.background(
			RoundedRectangle(cornerRadius: 24)
				.fill(Color("InputBackgroundColor"))
		)
	}
}

#Preview {
	HomeView()
}
