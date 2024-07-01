import SwiftUI
import Observation
import SwiftUINavigation

@MainActor
@Observable
final class Step1ViewModel {
    var addItem: Item?
    var editItem: Item?
    
    func addButtonTapped() {
        addItem = .init(title: "Add")
    }
    
    func editButtonTapped() {
        editItem = .init(title: "Edit")
    }
}

struct Step1View: View {
    @State var model = Step1ViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    model.addButtonTapped()
                } label: {
                    Text("Add Item")
                }
                .padding(.bottom, 16)

                Button {
                    model.editButtonTapped()
                } label: {
                    Text("Edit Item")
                }
            }
            .navigationDestination(item: $model.addItem) { item in
                AddItemView(item: item)
            }
            .navigationDestination(item: $model.editItem) { item in
                EditItemView(item: item)
            }
        }
    }
}

#Preview {
    Step1View()
}
