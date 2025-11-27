import SwiftUI

struct HomeView: View {
	@StateObject private var viewModel = HomeViewModel()

	var body: some View {
		NavigationView {
			ScrollView(showsIndicators: false) {
				// Player card
				VStack(alignment: .leading, spacing: 16) {
					PlayerCard(
						player: viewModel.currentPlayer,
						onTap: viewModel.viewProfile
					)
					PlayerStatsCard(player: viewModel.currentPlayer)
				}
				.padding(.horizontal, 20)
				.padding(.top, 20)
				// Quick actions
				VStack(alignment: .leading, spacing: 36) {
					VStack(alignment: .leading, spacing: 20) {
						Text("quick_actions_title")
							.font(.system(size: 20, weight: .semibold))
							.foregroundColor(Color("TextColor"))
						QuickActions(
							onOrganizeMatch: viewModel.organizeMatch,
							onFindMatch: viewModel.findMatch
						)
					}
					.padding(.horizontal, 20)
					// My matches
					VStack(alignment: .leading, spacing: 20) {
						HStack {
							Text("my_matches_title")
								.font(.system(size: 20, weight: .semibold))
								.foregroundColor(Color("TextColor"))
							Spacer()
							Button(action: viewModel.viewAllMyMatches) {
								HStack(spacing: 4) {
									Text("view_all")
										.font(.system(size: 12, weight: .semibold))
									Image(systemName: "chevron.right")
										.font(.system(size: 8, weight: .semibold))
								}
								.foregroundColor(Color("TextColor").opacity(0.6))
							}
							.buttonStyle(.plain)
						}
						.padding(.horizontal, 20)
						// Empty state view
						if viewModel.myMatches.isEmpty {
							EmptyStateView(
								icon: "sportscourt",
								title: "Nessuna partita in programma",
								subtitle: "Partecipa a una partita per vederla qui!"
							)
							.padding(.horizontal, 20)
						} else {
							VStack(spacing: 12) {
								ForEach(viewModel.myMatches) { match in
									MatchListItem(match: match) {
										viewModel.selectMatch(match)
									}
								}
							}
							.padding(.horizontal, 20)
						}
					}
					// Nearby matches
					VStack(alignment: .leading, spacing: 20) {
						HStack {
							Text("nearby_matches_title")
								.font(.system(size: 20, weight: .semibold))
								.foregroundColor(Color("TextColor"))
							Spacer()
							Button(action: viewModel.viewAllNearbyMatches) {
								HStack(spacing: 4) {
									Text("view_all")
										.font(.system(size: 12, weight: .semibold))
									Image(systemName: "chevron.right")
										.font(.system(size: 8, weight: .semibold))
								}
								.foregroundColor(Color("TextColor").opacity(0.6))
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
					// Action Cards
					VStack(alignment: .leading, spacing: 20) {
						Text("actions_section_title")
							.font(.system(size: 20, weight: .semibold))
							.foregroundColor(Color("TextColor"))
							.padding(.horizontal, 20)
						ActionCards(
							pendingReviews: viewModel.pendingReviews,
							badgesEarned: viewModel.badgesEarned,
							friendsCount: viewModel.friendsCount,
							onReviewPlayers: viewModel.reviewPlayers,
							onViewBadges: viewModel.viewBadges,
							onViewFriends: viewModel.viewFriends,
							onExploreFields: viewModel.exploreFields
						)
						.padding(.horizontal, 20)
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
		.sheet(isPresented: $viewModel.showMatchDetail) {
			if let match = viewModel.selectedMatch {
				MatchDetailSheet(match: match)
			}
		}
	}
}

#Preview {
	HomeView()
}
