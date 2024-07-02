import SwiftUI
import Observation

@MainActor
@Observable
final class Step3ViewModel {
    var isPresentedLoading = false
    var loadingText = ""

    func asyncFunction() async {
        isPresentedLoading = true
        loadingText = "Now loading"
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isPresentedLoading = false
        loadingText = ""
    }
}

struct Step3View: View {
    @State var model = Step3ViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Button {
                    Task { await model.asyncFunction() }
                } label: {
                    Text("Start async function")
                }
            }
            .loading(isPresented: $model.isPresentedLoading, text: $model.loadingText)
        }
    }
}

#Preview {
    Step3View()
}

