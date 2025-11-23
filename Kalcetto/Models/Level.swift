import Foundation
import SwiftUI

struct Level: Identifiable, Codable {
	let id: UUID
	let name: String
	let tier: Int
	let minPoints: Int
	let maxPoints: Int
	let color: String

	init(
		id: UUID = UUID(),
		name: String,
		tier: Int,
		minPoints: Int,
		maxPoints: Int,
		color: String
	) {
		self.id = id
		self.name = name
		self.tier = tier
		self.minPoints = minPoints
		self.maxPoints = maxPoints
		self.color = color
	}

	var displayColor: Color {
		switch color {
		case "bronze": return Color(red: 0.8, green: 0.5, blue: 0.2)
		case "silver": return Color(red: 0.75, green: 0.75, blue: 0.75)
		case "gold": return Color(red: 1.0, green: 0.84, blue: 0.0)
		case "platinum": return Color(red: 0.58, green: 0.82, blue: 0.87)
		case "diamond": return Color(red: 0.72, green: 0.87, blue: 1.0)
		default: return .gray
		}
	}

	static let levels: [Level] = [
		Level(
			name: "Principiante",
			tier: 1,
			minPoints: 0,
			maxPoints: 100,
			color: "bronze"
		),
		Level(
			name: "Amatore",
			tier: 2,
			minPoints: 101,
			maxPoints: 250,
			color: "bronze"
		),
		Level(
			name: "Intermedio",
			tier: 3,
			minPoints: 251,
			maxPoints: 500,
			color: "silver"
		),
		Level(
			name: "Avanzato",
			tier: 4,
			minPoints: 501,
			maxPoints: 1000,
			color: "gold"
		),
		Level(
			name: "Esperto",
			tier: 5,
			minPoints: 1001,
			maxPoints: 2000,
			color: "platinum"
		),
		Level(
			name: "Campione",
			tier: 6,
			minPoints: 2001,
			maxPoints: 5000,
			color: "diamond"
		),
	]

	static func getLevel(for points: Int) -> Level {
		return levels.last(where: { points >= $0.minPoints }) ?? levels[0]
	}
}
