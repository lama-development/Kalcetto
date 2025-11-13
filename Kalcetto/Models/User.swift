import Foundation
import SwiftUI

struct User: Codable {
	var name: String
	var surname: String
	var dateOfBirth: Date
	var profileImageData: Data?
	
	init(name: String = "", surname: String = "", dateOfBirth: Date = Date(), profileImageData: Data? = nil) {
		self.name = name
		self.surname = surname
		self.dateOfBirth = dateOfBirth
		self.profileImageData = profileImageData
	}
}
