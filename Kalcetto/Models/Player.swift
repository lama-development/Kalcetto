import Foundation

struct Player: Identifiable, Codable {
	let id: UUID
	var name: String
	var profileImage: String?
	var points: Int
	var matchesPlayed: Int
	var matchesWon: Int
	var matchesLost: Int
	var rating: Double

	init(
		id: UUID = UUID(),
		name: String,
		profileImage: String? = nil,
		points: Int = 0,
		matchesPlayed: Int = 0,
		matchesWon: Int = 0,
		matchesLost: Int = 0,
		rating: Double = 0.0
	) {
		self.id = id
		self.name = name
		self.profileImage = profileImage
		self.points = points
		self.matchesPlayed = matchesPlayed
		self.matchesWon = matchesWon
		self.matchesLost = matchesLost
		self.rating = rating
	}

	var level: Level {
		Level.getLevel(for: points)
	}

	var winRate: Double {
		guard matchesPlayed > 0 else { return 0 }
		return Double(matchesWon) / Double(matchesPlayed) * 100
	}

	// Mock data
	static let mock = Player(
		name: "Mario Rossi",
		profileImage: "person.fill",
		points: 450,
		matchesPlayed: 24,
		matchesWon: 15,
		matchesLost: 9,
		rating: 4.2
	)
}
