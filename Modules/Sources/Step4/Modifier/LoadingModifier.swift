import UIKit
import SwiftUI
import SwiftUINavigation

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
    @Binding var state: LoadingState?

    var body: some View {
        VStack(spacing: 8) {
            if let state {
                Text(state.text)
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
    @Binding var state: LoadingState?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue == true {
                    UIApplication.showProgress {
                        CustomProgressView(state: $state)
                    }
                } else {
                    UIApplication.hideProgress()
                }
            }
    }
}

struct LoadingState {
    var text: String
}

extension View {
    func loading(
        _ item: Binding<LoadingState?>
    ) -> some View {
        modifier(LoadingModifier(isPresented: Binding(item), state: item))
    }
}
