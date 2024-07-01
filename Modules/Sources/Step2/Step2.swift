import SwiftUI
import Observation

@MainActor
@Observable
final class Step2ViewModel {
    var isPresentedAlert = false
    var sheetItem: Item?
    var fullscreenItem: Item?
    var isPresentedConfirmationDialog = false
    var isPresentedPopover = false
    
    func alertButtonTapped() {
        isPresentedAlert = true
    }
    
    func sheetButtonTapped() {
        sheetItem = .init(title: "Sheet")
    }

    func sheetBarButtonTapped() {
        sheetItem = nil
    }
    
    func fullscreenCoverButtonTapped() {
        fullscreenItem = .init(title: "Fullscreen Cover")
    }

    func fullscreenBarButtonTapped() {
        fullscreenItem = nil
    }
    
    func confirmationDialogButtonTapped() {
        isPresentedConfirmationDialog = true
    }
    
    func popoverButtonTapped() {
        isPresentedPopover = true
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
                .popover(isPresented: $model.isPresentedPopover) {
                    Text("😄")
                        .presentationCompactAdaptation(.popover)
                }
            }
            .alert("Hello", isPresented: $model.isPresentedAlert, actions: {}) {
                Text("Hello!\nNice to meet you!!")
            }
            .sheet(item: $model.sheetItem) { item in
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
            .fullScreenCover(item: $model.fullscreenItem) { item in
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
            .confirmationDialog(
                "Dialog actions",
                isPresented: $model.isPresentedConfirmationDialog
            ) {
                Button("Action1") {
                    print("Action1")
                }
                Button("Action2") {
                    print("Action2")
                }
                Button("Action3") {
                    print("Action3")
                }
            }
        }
    }
}

#Preview {
    Step2View()
}

