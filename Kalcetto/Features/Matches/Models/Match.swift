import Foundation

enum MatchStatus: String, Codable {
	case upcoming = "upcoming"
	case ongoing = "ongoing"
	case completed = "completed"
	case cancelled = "cancelled"
}

struct Match: Identifiable, Codable {
	let id: UUID
	var title: String
	var location: String
	var city: String
	var date: Date
	var maxPlayers: Int
	var currentPlayers: Int
	var organizerId: UUID
	var organizerName: String
	var organizerHandle: String
	var organizerRating: Double
	var status: MatchStatus
	var distance: Double?  // in km
	var latitude: Double?
	var longitude: Double?
	var players: [Player]?

	init(
		id: UUID = UUID(),
		title: String,
		location: String,
		city: String,
		date: Date,
		maxPlayers: Int,
		currentPlayers: Int,
		organizerId: UUID,
		organizerName: String,
		organizerHandle: String,
		organizerRating: Double,
		status: MatchStatus = .upcoming,
		distance: Double? = nil,
		latitude: Double? = nil,
		longitude: Double? = nil,
		players: [Player]? = nil
	) {
		self.id = id
		self.title = title
		self.location = location
		self.city = city
		self.date = date
		self.maxPlayers = maxPlayers
		self.currentPlayers = currentPlayers
		self.organizerId = organizerId
		self.organizerName = organizerName
		self.organizerHandle = organizerHandle
		self.organizerRating = organizerRating
		self.status = status
		self.distance = distance
		self.latitude = latitude
		self.longitude = longitude
		self.players = players
	}

	var spotsLeft: Int {
		maxPlayers - currentPlayers
	}

	var isFull: Bool {
		currentPlayers >= maxPlayers
	}

	var actualCurrentPlayers: Int {
		// Include the organizer in the count
		let playersCount = players?.count ?? 0
		return playersCount + 1  // +1 for the organizer
	}

	var formattedDistance: String {
		guard let distance = distance else { return "" }
		if distance < 1 {
			return String(format: "%.0f m", distance * 1000)
		} else {
			return String(format: "%.1f km", distance)
		}
	}
}
