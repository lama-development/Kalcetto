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
		return playersCount + 1 // +1 for the organizer
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
			distance: 0.8,
			latitude: 45.4465,
			longitude: 8.6213,
			players: [
				Player(name: "Marco R.", handle: "marco_r", points: 320, matchesPlayed: 15, matchesWon: 10, matchesLost: 5, rating: 4.5),
				Player(name: "Giulia S.", handle: "giulia_s", points: 290, matchesPlayed: 12, matchesWon: 8, matchesLost: 4, rating: 4.3),
				Player(name: "Andrea P.", handle: "andrea_p", points: 410, matchesPlayed: 20, matchesWon: 14, matchesLost: 6, rating: 4.7),
				Player(name: "Sara T.", handle: "sara_t", points: 180, matchesPlayed: 8, matchesWon: 5, matchesLost: 3, rating: 4.0),
				Player(name: "Davide M.", handle: "davide_m", points: 350, matchesPlayed: 18, matchesWon: 11, matchesLost: 7, rating: 4.4),
				Player(name: "Chiara L.", handle: "chiara_l", points: 240, matchesPlayed: 10, matchesWon: 6, matchesLost: 4, rating: 4.1),
				Player(name: "Francesco B.", handle: "francesco_b", points: 480, matchesPlayed: 25, matchesWon: 18, matchesLost: 7, rating: 4.8)
			]
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
			distance: 1.2,
			latitude: 45.4642,
			longitude: 9.1900,
			players: [
				Player(name: "Luca V.", handle: "luca_v", points: 290, matchesPlayed: 14, matchesWon: 9, matchesLost: 5, rating: 4.2),
				Player(name: "Elena G.", handle: "elena_g", points: 330, matchesPlayed: 16, matchesWon: 11, matchesLost: 5, rating: 4.6),
				Player(name: "Matteo F.", handle: "matteo_f", points: 200, matchesPlayed: 9, matchesWon: 5, matchesLost: 4, rating: 3.9),
				Player(name: "Valentina C.", handle: "valentina_c", points: 380, matchesPlayed: 19, matchesWon: 13, matchesLost: 6, rating: 4.5),
				Player(name: "Simone D.", handle: "simone_d", points: 420, matchesPlayed: 22, matchesWon: 15, matchesLost: 7, rating: 4.7),
				Player(name: "Alessia N.", handle: "alessia_n", points: 260, matchesPlayed: 11, matchesWon: 7, matchesLost: 4, rating: 4.3),
				Player(name: "Roberto K.", handle: "roberto_k", points: 310, matchesPlayed: 15, matchesWon: 10, matchesLost: 5, rating: 4.4),
				Player(name: "Federica P.", handle: "federica_p", points: 270, matchesPlayed: 12, matchesWon: 8, matchesLost: 4, rating: 4.2),
				Player(name: "Alessandro Z.", handle: "alessandro_z", points: 450, matchesPlayed: 23, matchesWon: 17, matchesLost: 6, rating: 4.8),
				Player(name: "Martina W.", handle: "martina_w", points: 190, matchesPlayed: 8, matchesWon: 4, matchesLost: 4, rating: 3.8)
			]
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
			distance: 2.5,
			latitude: 45.0703,
			longitude: 7.6869
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
			distance: 1.5,
			latitude: 45.4465,
			longitude: 8.6213
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
			distance: 3.0,
			latitude: 41.9028,
			longitude: 12.4964
		),
	]
}
