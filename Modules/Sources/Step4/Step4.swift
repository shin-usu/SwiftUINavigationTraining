import SwiftUI
import Observation
import SwiftUINavigation

@MainActor
@Observable
final class Step4ViewModel {
    @CasePathable
    enum Destination {
        case loading(LoadingState)
        case alert(AlertState<AlertAction>)
        
        enum AlertAction {
            case retryAsyncFunction
        }
    }
    
    var destination: Destination?

    func asyncFunction() async {
        destination = .loading(LoadingState(text: "Now loading"))
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        destination = .loading(LoadingState(text: "A little more"))
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let success = Bool.random()
        if success {
            destination = .alert(AlertState(title: {
                TextState("Success")
            }, message: {
                TextState("Result is success!!")
            }))
        } else {
            destination = .alert(AlertState(title: {
                TextState("Failure")
            }, actions: {
                ButtonState(action: .retryAsyncFunction) {
                    TextState("Retry")
                }
                ButtonState {
                    TextState("OK")
                }
            }, message: {
                TextState("Result is success!!")
            }))
        }
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
            .loading($model.destination.loading)
            .alert($model.destination.alert) { action in
                switch action {
                case .retryAsyncFunction:
                    Task { await model.asyncFunction() }
                case .none:
                    break
                }
            }
        }
    }
}

#Preview {
    Step4View()
}

