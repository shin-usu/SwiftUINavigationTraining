import SwiftUI
import Observation
import SwiftUINavigation

@MainActor
@Observable
final class Step3ViewModel {
    @CasePathable
    enum Destination {
        case loading(LoadingState)
    }

    var destination: Destination?

    func asyncFunction() async {
        destination = .loading(LoadingState(text: "Now loading"))
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        destination = nil
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
            .loading($model.destination.loading)
        }
    }
}

#Preview {
    Step3View()
}

