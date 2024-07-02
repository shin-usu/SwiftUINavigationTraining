import SwiftUI
import Observation
import SwiftUINavigation

@MainActor
@Observable
final class Step2ViewModel {
    @CasePathable
    enum Destination {
        case alert(AlertState<Never>)
        case itemSheet(Item)
        case itemFullscreenCover(Item)
        case smilePopover(Item)
        case confirmationDialog(ConfirmationDialogState<DialogAction>)
        
        enum DialogAction {
            case action1
            case action2
            case action3
        }
    }
    
    var destination: Destination?
    
    func alertButtonTapped() {
        destination = .alert(AlertState(title: {
            TextState("Hello")
        }, message: {
            TextState("Hello!\nNice to meet you!!")
        }))
    }
    
    func sheetButtonTapped() {
        destination = .itemSheet(.init(title: "Sheet"))
    }

    func sheetBarButtonTapped() {
        destination = nil
    }
    
    func fullscreenCoverButtonTapped() {
        destination = .itemFullscreenCover(.init(title: "Fullscreen Cover"))
    }

    func fullscreenBarButtonTapped() {
        destination = nil
    }
    
    func confirmationDialogButtonTapped() {
        destination = .confirmationDialog(
            ConfirmationDialogState(
                title: {
                    TextState("Dialog actions")
                },
                actions: {
                    ButtonState(action: .action1) {
                        TextState("Action1")
                    }
                    ButtonState(action: .action2) {
                        TextState("Action2")
                    }
                    ButtonState(role: .destructive, action: .action3) {
                        TextState("Action3")
                    }
                }
            )
        )
    }
    
    func popoverButtonTapped() {
        destination = .smilePopover(.init(title: "😄"))
    }
}

struct Step2View: View {
    @State var model = Step2ViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Button {
                    model.sheetButtonTapped()
                } label: {
                    Text("Sheet")
                }

                Button {
                    model.fullscreenCoverButtonTapped()
                } label: {
                    Text("Fullscreen Cover")
                }
                
                Button {
                    model.alertButtonTapped()
                } label: {
                    Text("Alert")
                }
                
                Button {
                    model.confirmationDialogButtonTapped()
                } label: {
                    Text("Confirmation Dialog")
                }
                
                Button {
                    model.popoverButtonTapped()
                } label: {
                    Text("Popover")
                }
                .popover(item: $model.destination.smilePopover) { item in
                    ItemView(item: item)
                        .presentationCompactAdaptation(.popover)
                }
            }
            .alert($model.destination.alert)
            .sheet(item: $model.destination.itemSheet) { item in
                NavigationStack {
                    ItemView(item: item)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("", systemImage: "multiply.circle") {
                                    model.sheetBarButtonTapped()
                                }
                            }
                        }
                }
            }
            .fullScreenCover(item: $model.destination.itemFullscreenCover) { item in
                NavigationStack {
                    ItemView(item: item)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("", systemImage: "multiply.circle") {
                                    model.fullscreenBarButtonTapped()
                                }
                            }
                        }
                }
            }
            .confirmationDialog($model.destination.confirmationDialog) { action in
                switch action {
                case .action1:
                    print("Action1")
                case .action2:
                    print("Action2")
                case .action3:
                    print("Action3")
                case .none:
                    break
                }
            }
        }
    }
}

#Preview {
    Step2View()
}

