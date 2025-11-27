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
	var status: MatchStatus
	var distance: Double?  // in km
	var latitude: Double?
	var longitude: Double?

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
		status: MatchStatus = .upcoming,
		distance: Double? = nil,
		latitude: Double? = nil,
		longitude: Double? = nil
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
		self.status = status
		self.distance = distance
		self.latitude = latitude
		self.longitude = longitude
	}

	var spotsLeft: Int {
		maxPlayers - currentPlayers
	}

	var isFull: Bool {
		currentPlayers >= maxPlayers
	}

	var formattedDistance: String {
		guard let distance = distance else { return "" }
		if distance < 1 {
			return String(format: "%.0f m", distance * 1000)
		} else {
			return String(format: "%.1f km", distance)
		}
	}

	// Mock data
	static let mockNearby: [Match] = [
		Match(
			title: "Partita serale",
			location: "Campo Sportivo Centro",
			city: "Novara",
			date: Date().addingTimeInterval(81400),
			maxPlayers: 10,
			currentPlayers: 7,
			organizerId: UUID(),
			organizerName: "Luca B.",
			distance: 0.8
		),
		Match(
			title: "Torneo del weekend del porco dio madonna",
			location: "Oratorio San Marco",
			city: "Milano",
			date: Date().addingTimeInterval(172800),
			maxPlayers: 12,
			currentPlayers: 10,
			organizerId: UUID(),
			organizerName: "Giovanni M.",
			distance: 1.2
		),
		Match(
			title: "Calcetto amichevole",
			location: "Polisportiva Nord",
			city: "Torino",
			date: Date().addingTimeInterval(259200),
			maxPlayers: 8,
			currentPlayers: 8,
			organizerId: UUID(),
			organizerName: "Paolo R.",
			distance: 2.5
		),
	]

	static let mockMyMatches: [Match] = [
		Match(
			title: "Partita domenicale",
			location: "Campo Sportivo Sud",
			city: "Novara",
			date: Date().addingTimeInterval(604800),
			maxPlayers: 10,
			currentPlayers: 6,
			organizerId: UUID(),
			organizerName: "Te stesso",
			status: .upcoming,
			distance: 1.5
		),
		Match(
			title: "Torneo comunale",
			location: "Stadio Comunale",
			city: "Roma",
			date: Date().addingTimeInterval(-86400),
			maxPlayers: 16,
			currentPlayers: 16,
			organizerId: UUID(),
			organizerName: "Marco T.",
			status: .completed,
			distance: 3.0
		),
	]
}
