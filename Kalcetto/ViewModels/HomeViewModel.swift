import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
	@Published var currentPlayer: Player
	@Published var nearbyMatches: [Match] = []
	@Published var myMatches: [Match] = []
	@Published var isLoading: Bool = false
    
	init() {
		// Initialize with mock data
		self.currentPlayer = Player.mock
		self.nearbyMatches = Match.mockNearby
		self.myMatches = Match.mockMyMatches
	}
    
	func loadData() {
		isLoading = true
        
		// Simulate network call
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			self?.isLoading = false
		}
	}
    
	func organizeMatch() {
		// TODO: Navigate to organize match screen
		print("Organize match tapped")
	}
    
	func findMatch() {
		// TODO: Navigate to find match screen
		print("Find match tapped")
	}
    
	func viewProfile() {
		// TODO: Navigate to profile screen
		print("View profile tapped")
	}
    
	func viewAllNearbyMatches() {
		// TODO: Navigate to all nearby matches screen
		print("View all nearby matches tapped")
	}
    
	func viewAllMyMatches() {
		// TODO: Navigate to all my matches screen
		print("View all my matches tapped")
	}
    
	func selectMatch(_ match: Match) {
		// TODO: Navigate to match detail screen
		print("Selected match: \(match.title)")
	}
}
