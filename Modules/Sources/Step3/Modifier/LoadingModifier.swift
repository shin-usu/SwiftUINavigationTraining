import UIKit
import SwiftUI

extension UIApplication {
    static var progressWindow: UIWindow?

    static func showProgress<Content: View>(@ViewBuilder builder: () -> Content) {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        let vc = UIHostingController(rootView: builder())
        vc.view.backgroundColor = .clear
        window.rootViewController = vc
        window.windowLevel = .alert - 1
        progressWindow = window
        window.makeKeyAndVisible()
    }

    static func hideProgress() {
        progressWindow = nil
    }
}

struct CustomProgressView: View {
    @Binding var text: String

    var body: some View {
        VStack(spacing: 8) {
            if !text.isEmpty {
                Text(text)
            }
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
        .ignoresSafeArea(.all)
    }
}

struct LoadingModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue == true {
                    UIApplication.showProgress {
                        CustomProgressView(text: _text)
                    }
                } else {
                    UIApplication.hideProgress()
                }
            }
    }
}

extension View {
    func loading(isPresented: Binding<Bool>, text: Binding<String> = .constant("")) -> some View {
        modifier(LoadingModifier(isPresented: isPresented, text: text))
    }
}
