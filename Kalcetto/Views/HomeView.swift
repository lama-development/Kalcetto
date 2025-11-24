import SwiftUI

struct HomeView: View {
	@StateObject private var viewModel = HomeViewModel()

	var body: some View {
		NavigationView {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 36) {
					// Quick actions
					VStack(alignment: .leading, spacing: 12) {
						QuickActions(
							onOrganizeMatch: viewModel.organizeMatch,
							onFindMatch: viewModel.findMatch
						)
					}
					.padding(.horizontal, 20)
					// Nearby matches
					VStack(alignment: .leading, spacing: 24) {
						HStack {
							Text("nearby_matches")
								.font(.system(size: 24, weight: .semibold))
								.foregroundColor(Color("TextColor"))
							Spacer()
							Button(action: viewModel.viewAllNearbyMatches) {
								HStack(spacing: 4) {
									Text("view_all")
										.font(.system(size: 12, weight: .semibold))
									Image(systemName: "chevron.right")
										.font(.system(size: 10, weight: .semibold))
								}
								.foregroundColor(Color.accentColor)
								.padding(.horizontal, 12)
								.padding(.vertical, 6)
								.background(
									Capsule()
										.fill(Color.accentColor.opacity(0.15))
								)
								.overlay(
									Capsule()
										.strokeBorder(Color.accentColor.opacity(0.1), lineWidth: 1)
								)
							}
							.buttonStyle(.plain)
						}
						.padding(.horizontal, 20)
						// Empty state view
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

#Preview {
	HomeView()
}
