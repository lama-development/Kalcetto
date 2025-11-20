import PhotosUI
import SwiftUI

struct ProfileSetupView: View {
	@EnvironmentObject var appState: AppState
	@State private var fullName: String = ""
	@State private var nickname: String = ""
	@State private var profileImage: UIImage?
	@State private var showImagePicker = false
	@State private var photoPickerItem: PhotosPickerItem?
	@State private var errorMessage: String? = nil
	@FocusState private var focusedField: Field?

	enum Field: Hashable {
		case fullName
		case nickname
	}

	private var isFormValid: Bool {
		!fullName.trimmingCharacters(in: .whitespaces).isEmpty
			&& !nickname.trimmingCharacters(in: .whitespaces).isEmpty
	}

	var body: some View {
		ZStack {
			Color("BackgroundColor")
				.ignoresSafeArea()
			VStack(spacing: 0) {
				ScrollView(showsIndicators: false) {
					VStack(spacing: 32) {
						VStack(spacing: 12) {
							Text("profile_setup_title")
								.font(.custom("Onest", size: 32))
								.fontWeight(.bold)
								.foregroundColor(Color("TextColor"))
								.multilineTextAlignment(.center)
							Text("profile_setup_subtitle")
								.font(.custom("Onest", size: 18))
								.fontWeight(.regular)
								.foregroundColor(Color("TextColor").opacity(0.8))
								.multilineTextAlignment(.center)
								.padding(.horizontal, 32)
						}
						.padding(.top, 40)
						// Profile Picture Section
						VStack(spacing: 16) {
							ZStack {
							// Main profile image circle
							if let profileImage = profileImage {
								Image(uiImage: profileImage)
									.resizable()
									.scaledToFill()
									.frame(width: 130, height: 130)
								.clipShape(Circle())
							} else {
								Circle()
									.fill(Color("AccentColor").opacity(0.1))
									.frame(width: 130, height: 130)
									.overlay(
										Image(systemName: "person.fill")
											.font(.system(size: 50))
											.foregroundColor(Color("AccentColor"))
									)
							}
							// Camera button overlay
								Circle()
									.fill(Color("AccentColor"))
									.frame(width: 40, height: 40)
									.overlay(
										Image(systemName: "camera.fill")
											.foregroundColor(Color("TextColorInverted"))
											.font(.system(size: 18, weight: .medium))
									)
									.offset(x: 45, y: 45)
							}
							.onTapGesture {
								showImagePicker = true
								focusedField = nil
							}
							Text("profile_setup_tap_to_add_photo")
								.font(.custom("Onest", size: 14))
								.fontWeight(.regular)
								.foregroundColor(Color("TextColor").opacity(0.6))
						}
						// Form Fields
						VStack(spacing: 20) {
							// Full Name Field
							VStack(alignment: .leading, spacing: 8) {
								Text("profile_setup_fullname")
									.font(.custom("Onest", size: 14))
									.fontWeight(.medium)
									.foregroundColor(Color("TextColor"))
								TextField("profile_setup_fullname_placeholder", text: $fullName)
									.font(.custom("Onest", size: 16))
									.fontWeight(.regular)
									.textFieldStyle(.plain)
									.padding()
									.background(
										RoundedRectangle(cornerRadius: 14)
											.fill(Color("InputBackgroundColor"))
											.overlay(
												RoundedRectangle(cornerRadius: 14)
													.stroke(
														focusedField == .fullName
															? Color("AccentColor") : Color.clear,
														lineWidth: 2
													)
											)
									)
									.foregroundColor(Color("TextColor"))
									.autocapitalization(.words)
									.textContentType(.name)
									.focused($focusedField, equals: .fullName)
									.submitLabel(.next)
									.onSubmit {
										focusedField = .nickname
									}
							}
							// Nickname Field
							VStack(alignment: .leading, spacing: 8) {
								Text("profile_setup_nickname")
									.font(.custom("Onest", size: 14))
									.fontWeight(.medium)
									.foregroundColor(Color("TextColor"))
								TextField("profile_setup_nickname_placeholder", text: $nickname)
									.font(.custom("Onest", size: 16))
									.fontWeight(.regular)
									.textFieldStyle(.plain)
									.padding()
									.background(
										RoundedRectangle(cornerRadius: 14)
											.fill(Color("InputBackgroundColor"))
											.overlay(
												RoundedRectangle(cornerRadius: 14)
													.stroke(
														focusedField == .nickname
															? Color("AccentColor") : Color.clear,
														lineWidth: 2
													)
											)
									)
									.foregroundColor(Color("TextColor"))
									.autocapitalization(.none)
									.textContentType(.username)
									.focused($focusedField, equals: .nickname)
									.submitLabel(.done)
									.onSubmit {
										if isFormValid {
											validateAndComplete()
										}
									}
							}
							// Error message
							if let errorMessage = errorMessage {
								HStack(spacing: 8) {
									Image(systemName: "exclamationmark.circle.fill")
										.foregroundColor(.red)
										.font(.system(size: 14))
									Text(errorMessage)
										.font(.custom("Onest", size: 14))
										.fontWeight(.medium)
										.foregroundColor(.red)
								}
								.padding()
								.frame(maxWidth: .infinity, alignment: .leading)
								.background(
									RoundedRectangle(cornerRadius: 12)
										.fill(Color.red.opacity(0.1))
								)
								.transition(.scale.combined(with: .opacity))
							}
						}
						.padding(.horizontal, 28)
						Spacer(minLength: 100)
					}
				}
				.scrollDismissesKeyboard(.interactively)
				// Bottom Button
				VStack(spacing: 0) {
					Divider()
						.background(Color("TextColor").opacity(0.1))
					Button(action: {
						focusedField = nil
						validateAndComplete()
					}) {
						HStack(spacing: 10) {
							Text("profile_setup_cta")
								.font(.custom("Onest", size: 18))
								.fontWeight(.semibold)
								.foregroundColor(Color("TextColorInverted"))
						}
						.frame(maxWidth: .infinity)
						.frame(height: 48)
					}
					.buttonStyle(.glassProminent)
					.tint(Color("AccentColor"))
					.disabled(!isFormValid)
					.padding(.horizontal, 28)
					.padding(.top, 16)
					.padding(.bottom, 20)
				}
				.background(
					Color("BackgroundColor")
						.ignoresSafeArea(edges: .bottom)
				)
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
					withAnimation(.easeInOut(duration: 0.3)) {
						profileImage = image
					}
				}
			}
		}
	}

	private func validateAndComplete() {
		// Clear previous errors
		errorMessage = nil

		// Example validation logic
		let trimmedNickname = nickname.trimmingCharacters(in: .whitespaces)
			.lowercased()

		// Check for reserved nicknames
		if trimmedNickname == "admin" || trimmedNickname == "kalcetto" {
			withAnimation {
				errorMessage = "profile_setup_nickname_already_taken"
			}
			return
		}

		// Check nickname length
		if trimmedNickname.count < 3 {
			withAnimation {
				errorMessage = "Il nickname deve contenere almeno 3 caratteri"
			}
			return
		}

		let imageData = profileImage?.jpegData(compressionQuality: 0.7)
		let user = User(
			fullName: fullName.trimmingCharacters(in: .whitespaces),
			nickname: nickname.trimmingCharacters(in: .whitespaces),
			profileImageData: imageData
		)

		withAnimation(.easeInOut(duration: 0.3)) {
			appState.completeProfileSetup(with: user)
		}
	}
}

#Preview {
	ProfileSetupView()
		.environmentObject(AppState())
}
