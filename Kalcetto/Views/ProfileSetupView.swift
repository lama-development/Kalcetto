import PhotosUI
import SwiftUI

struct ProfileSetupView: View {
	@EnvironmentObject var appState: AppState
	@State private var name: String = ""
	@State private var surname: String = ""
	@State private var dateOfBirth: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
	@State private var profileImage: UIImage?
	@State private var showImagePicker = false
	@State private var photoPickerItem: PhotosPickerItem?

	private var isFormValid: Bool {
		!name.trimmingCharacters(in: .whitespaces).isEmpty
			&& !surname.trimmingCharacters(in: .whitespaces).isEmpty
	}

	var body: some View {
		ZStack {
			Color("BackgroundColor")
				.ignoresSafeArea()
			ScrollView {
				VStack(spacing: 24) {
					// Header
					VStack(spacing: 8) {
						Text("profile_setup_title")
							.font(.largeTitle)
							.bold()
							.foregroundColor(Color("TextColor"))
						
						Text("profile_setup_subtitle")
							.font(.body)
							.foregroundColor(Color("TextColor"))
							.opacity(0.7)
							.multilineTextAlignment(.center)
					}
					.padding(.top, 40)
					
					// Profile Picture Section
					VStack(spacing: 16) {
						ZStack {
							if let profileImage = profileImage {
								Image(uiImage: profileImage)
									.resizable()
									.scaledToFill()
									.frame(width: 120, height: 120)
									.clipShape(Circle())
							} else {
								Circle()
									.fill(Color.gray.opacity(0.2))
									.frame(width: 120, height: 120)
									.overlay(
										Image(systemName: "person.fill")
											.font(.system(size: 50))
											.foregroundColor(.gray)
									)
							}

							// Edit button overlay
							Circle()
								.fill(Color("AccentColor"))
								.frame(width: 36, height: 36)
								.overlay(
									Image(systemName: "camera.fill")
										.font(.system(size: 16))
										.foregroundColor(Color("TextColorInverted"))
								)
								.offset(x: 42, y: 42)
						}
						.onTapGesture {
							showImagePicker = true
						}

						Text("profile_setup_tap_to_change")
							.font(.caption)
							.foregroundColor(Color("TextColor"))
							.opacity(0.6)
					}
					.padding(.vertical, 16)

					// Form Fields
					VStack(spacing: 20) {
						// Name Field
						VStack(alignment: .leading, spacing: 8) {
							Text("profile_setup_name")
								.font(.subheadline)
								.fontWeight(.medium)
								.foregroundColor(Color("TextColor"))

							TextField("profile_setup_name_placeholder", text: $name)
								.textFieldStyle(.plain)
								.padding()
								.background(Color.white)
								.cornerRadius(12)
								.overlay(
									RoundedRectangle(cornerRadius: 12)
										.stroke(Color.gray.opacity(0.2), lineWidth: 1)
								)
						}

						// Surname Field
						VStack(alignment: .leading, spacing: 8) {
							Text("profile_setup_surname")
								.font(.subheadline)
								.fontWeight(.medium)
								.foregroundColor(Color("TextColor"))

							TextField("profile_setup_surname_placeholder", text: $surname)
								.textFieldStyle(.plain)
								.padding()
								.background(Color.white)
								.cornerRadius(12)
								.overlay(
									RoundedRectangle(cornerRadius: 12)
										.stroke(Color.gray.opacity(0.2), lineWidth: 1)
								)
						}
						
						// Date of Birth Field
						VStack(alignment: .leading, spacing: 8) {
							Text("profile_setup_date_of_birth")
								.font(.subheadline)
								.fontWeight(.medium)
								.foregroundColor(Color("TextColor"))
							
							DatePicker(
								"",
								selection: $dateOfBirth,
								in: ...Date(),
								displayedComponents: .date
							)
							.datePickerStyle(.compact)
							.labelsHidden()
							.padding()
							.background(Color.white)
							.cornerRadius(12)
							.overlay(
								RoundedRectangle(cornerRadius: 12)
									.stroke(Color.gray.opacity(0.2), lineWidth: 1)
							)
						}
					}
					.padding(.horizontal, 24)

					// Complete Button
					Button(action: {
						completeProfileSetup()
					}) {
						Text("profile_setup_complete")
							.font(.headline)
							.foregroundColor(.white)
							.frame(maxWidth: .infinity)
							.frame(height: 56)
							.background(isFormValid ? Color("AccentColor") : Color.gray)
							.cornerRadius(12)
					}
					.disabled(!isFormValid)
					.padding(.horizontal, 24)
					.padding(.top, 16)
					.padding(.bottom, 32)
				}
			}
		}
		.photosPicker(
			isPresented: $showImagePicker,
			selection: $photoPickerItem,
			matching: .images
		)
		.onChange(of: photoPickerItem) { _, newItem in
			Task {
				if let data = try? await newItem?.loadTransferable(type: Data.self),
					let image = UIImage(data: data)
				{
					profileImage = image
				}
			}
		}
	}

	private func completeProfileSetup() {
		let imageData = profileImage?.jpegData(compressionQuality: 0.7)
		let user = User(
			name: name.trimmingCharacters(in: .whitespaces),
			surname: surname.trimmingCharacters(in: .whitespaces),
			dateOfBirth: dateOfBirth,
			profileImageData: imageData
		)
		appState.completeProfileSetup(with: user)
	}
}

#Preview {
	ProfileSetupView()
		.environmentObject(AppState())
}
