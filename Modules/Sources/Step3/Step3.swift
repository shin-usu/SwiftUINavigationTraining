import SwiftUI
import Observation

@MainActor
@Observable
final class Step3ViewModel {
    var isPresentedLoading = false

    func asyncFunction() async {
        isPresentedLoading = true
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isPresentedLoading = false
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
            .loading(isPresented: $model.isPresentedLoading)
        }
    }
}

#Preview {
    Step3View()
}

