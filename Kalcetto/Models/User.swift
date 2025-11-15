import Foundation
import SwiftUI

struct User: Codable {
	var fullName: String
	var nickname: String
	var profileImageData: Data?

	init(
		fullName: String = "",
		nickname: String = "",
		profileImageData: Data? = nil
	) {
		self.fullName = fullName
		self.nickname = nickname
		self.profileImageData = profileImageData
	}
}
