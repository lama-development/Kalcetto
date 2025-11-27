import Foundation

enum MockData {

	// MARK: - Players

	enum Players {
		static let currentUser = Player(
			name: "Mario Rossi",
			handle: "mariorossi",
			profileImage: "figure.indoor.soccer",
			points: 450,
			matchesPlayed: 24,
			matchesWon: 15,
			matchesLost: 9,
			rating: 4.2
		)

		static let marcoR = Player(
			name: "Marco R.",
			handle: "marco_r",
			points: 320,
			matchesPlayed: 15,
			matchesWon: 10,
			matchesLost: 5,
			rating: 4.5
		)

		static let giuliaS = Player(
			name: "Giulia S.",
			handle: "giulia_s",
			points: 290,
			matchesPlayed: 12,
			matchesWon: 8,
			matchesLost: 4,
			rating: 4.3
		)

		static let andreaP = Player(
			name: "Andrea P.",
			handle: "andrea_p",
			points: 410,
			matchesPlayed: 20,
			matchesWon: 14,
			matchesLost: 6,
			rating: 4.7
		)

		static let saraT = Player(
			name: "Sara T.",
			handle: "sara_t",
			points: 180,
			matchesPlayed: 8,
			matchesWon: 5,
			matchesLost: 3,
			rating: 4.0
		)

		static let davideM = Player(
			name: "Davide M.",
			handle: "davide_m",
			points: 350,
			matchesPlayed: 18,
			matchesWon: 11,
			matchesLost: 7,
			rating: 4.4
		)

		static let chiaraL = Player(
			name: "Chiara L.",
			handle: "chiara_l",
			points: 240,
			matchesPlayed: 10,
			matchesWon: 6,
			matchesLost: 4,
			rating: 4.1
		)

		static let francescoB = Player(
			name: "Francesco B.",
			handle: "francesco_b",
			points: 480,
			matchesPlayed: 25,
			matchesWon: 18,
			matchesLost: 7,
			rating: 4.8
		)

		static let lucaV = Player(
			name: "Luca V.",
			handle: "luca_v",
			points: 290,
			matchesPlayed: 14,
			matchesWon: 9,
			matchesLost: 5,
			rating: 4.2
		)

		static let elenaG = Player(
			name: "Elena G.",
			handle: "elena_g",
			points: 330,
			matchesPlayed: 16,
			matchesWon: 11,
			matchesLost: 5,
			rating: 4.6
		)

		static let matteoF = Player(
			name: "Matteo F.",
			handle: "matteo_f",
			points: 200,
			matchesPlayed: 9,
			matchesWon: 5,
			matchesLost: 4,
			rating: 3.9
		)

		static let valentinaC = Player(
			name: "Valentina C.",
			handle: "valentina_c",
			points: 380,
			matchesPlayed: 19,
			matchesWon: 13,
			matchesLost: 6,
			rating: 4.5
		)

		static let simoneD = Player(
			name: "Simone D.",
			handle: "simone_d",
			points: 420,
			matchesPlayed: 22,
			matchesWon: 15,
			matchesLost: 7,
			rating: 4.7
		)

		static let alessiaN = Player(
			name: "Alessia N.",
			handle: "alessia_n",
			points: 260,
			matchesPlayed: 11,
			matchesWon: 7,
			matchesLost: 4,
			rating: 4.3
		)

		static let robertoK = Player(
			name: "Roberto K.",
			handle: "roberto_k",
			points: 310,
			matchesPlayed: 15,
			matchesWon: 10,
			matchesLost: 5,
			rating: 4.4
		)

		static let federicaP = Player(
			name: "Federica P.",
			handle: "federica_p",
			points: 270,
			matchesPlayed: 12,
			matchesWon: 8,
			matchesLost: 4,
			rating: 4.2
		)

		static let alessandroZ = Player(
			name: "Alessandro Z.",
			handle: "alessandro_z",
			points: 450,
			matchesPlayed: 23,
			matchesWon: 17,
			matchesLost: 6,
			rating: 4.8
		)

		static let martinaW = Player(
			name: "Martina W.",
			handle: "martina_w",
			points: 190,
			matchesPlayed: 8,
			matchesWon: 4,
			matchesLost: 4,
			rating: 3.8
		)

		/// All available mock players
		static let all: [Player] = [
			marcoR, giuliaS, andreaP, saraT, davideM, chiaraL, francescoB,
			lucaV, elenaG, matteoF, valentinaC, simoneD, alessiaN,
			robertoK, federicaP, alessandroZ, martinaW,
		]
	}

	// MARK: - Matches

	enum Matches {
		static let partitaSerale = Match(
			title: "Partita serale",
			location: "Campo Sportivo Centro",
			city: "Novara",
			date: Date().addingTimeInterval(81400),
			maxPlayers: 10,
			currentPlayers: 7,
			organizerId: UUID(),
			organizerName: "Luca B.",
			organizerHandle: "luca_b",
			organizerRating: 4.6,
			distance: 0.8,
			latitude: 45.4465,
			longitude: 8.6213,
			players: [
				Players.marcoR,
				Players.giuliaS,
				Players.andreaP,
				Players.saraT,
				Players.davideM,
				Players.chiaraL,
				Players.francescoB,
			]
		)

		static let torneoWeekend = Match(
			title: "Torneo del weekend del porco dio madonna",
			location: "Oratorio San Marco",
			city: "Milano",
			date: Date().addingTimeInterval(172800),
			maxPlayers: 12,
			currentPlayers: 10,
			organizerId: UUID(),
			organizerName: "Giovanni M.",
			organizerHandle: "giovanni_m",
			organizerRating: 4.9,
			distance: 1.2,
			latitude: 45.4642,
			longitude: 9.1900,
			players: [
				Players.lucaV,
				Players.elenaG,
				Players.matteoF,
				Players.valentinaC,
				Players.simoneD,
				Players.alessiaN,
				Players.robertoK,
				Players.federicaP,
				Players.alessandroZ,
				Players.martinaW,
			]
		)

		static let calcettoAmichevole = Match(
			title: "Calcetto amichevole",
			location: "Polisportiva Nord",
			city: "Torino",
			date: Date().addingTimeInterval(259200),
			maxPlayers: 8,
			currentPlayers: 8,
			organizerId: UUID(),
			organizerName: "Paolo R.",
			organizerHandle: "paolo_r",
			organizerRating: 4.3,
			distance: 2.5,
			latitude: 45.0703,
			longitude: 7.6869
		)

		static let partitaDomenicale = Match(
			title: "Partita domenicale",
			location: "Campo Sportivo Sud",
			city: "Novara",
			date: Date().addingTimeInterval(604800),
			maxPlayers: 10,
			currentPlayers: 6,
			organizerId: UUID(),
			organizerName: "Te stesso",
			organizerHandle: "testesso",
			organizerRating: 4.5,
			status: .upcoming,
			distance: 1.5,
			latitude: 45.4465,
			longitude: 8.6213
		)

		static let torneoComunale = Match(
			title: "Torneo comunale",
			location: "Stadio Comunale",
			city: "Roma",
			date: Date().addingTimeInterval(-86400),
			maxPlayers: 16,
			currentPlayers: 16,
			organizerId: UUID(),
			organizerName: "Marco T.",
			organizerHandle: "marco_t",
			organizerRating: 4.7,
			status: .completed,
			distance: 3.0,
			latitude: 41.9028,
			longitude: 12.4964
		)

		/// Nearby matches available to join
		static let nearby: [Match] = [
			partitaSerale,
			torneoWeekend,
			calcettoAmichevole,
		]

		/// User's registered matches
		static let myMatches: [Match] = [
			partitaDomenicale,
			torneoComunale,
		]
	}
}
