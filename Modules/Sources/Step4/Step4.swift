import SwiftUI
import Observation

@MainActor
@Observable
final class Step4ViewModel {
    var isPresentedSuccessAlert = false
    var isPresentedFailureAlert = false
    var isPresentedLoading = false
    var loadingText = ""

    func asyncFunction() async {
        isPresentedLoading = true
        loadingText = "Now loading"
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        loadingText = "A little more"
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let success = Bool.random()
        if success {
            isPresentedSuccessAlert = true
        } else {
            isPresentedFailureAlert = true
        }
        isPresentedLoading = false
    }
}

struct Step4View: View {
    @State var model = Step4ViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Button {
                    Task { await model.asyncFunction() }
                } label: {
                    Text("Start async function")
                }
            }
            .loading(
                isPresented: $model.isPresentedLoading,
                text: $model.loadingText
            )
            .alert(
                "Success",
                isPresented: $model.isPresentedSuccessAlert,
                actions: {},
                message: {
                    Text("Result is success!!")
                }
            )
            .alert(
                "Failure",
                isPresented: $model.isPresentedFailureAlert,
                actions: {
                    Button("Retry") {
                        Task { await model.asyncFunction() }
                    }
                    Button("OK") {}
                },
                message: {
                    Text("Result is failure")
                }
            )
        }
    }
}

#Preview {
    Step4View()
}

