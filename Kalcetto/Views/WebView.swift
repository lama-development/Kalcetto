import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
	let url: URL
	
	func makeUIView(context: Context) -> WKWebView {
		let webView = WKWebView()
		webView.navigationDelegate = context.coordinator
		return webView
	}
	
	func updateUIView(_ webView: WKWebView, context: Context) {
		let request = URLRequest(url: url)
		webView.load(request)
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator()
	}
	
	class Coordinator: NSObject, WKNavigationDelegate {
		// Handle navigation if needed
	}
}

struct WebViewSheet: View {
	let url: URL
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		NavigationView {
			WebView(url: url)
				.ignoresSafeArea()
				.navigationTitle("terms_of_service")
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button(action: {
							dismiss()
						}) {
							Image(systemName: "xmark.circle.fill")
								.font(.system(size: 24))
								.foregroundColor(Color("TextColor").opacity(0.6))
						}
					}
				}
		}
	}
}
