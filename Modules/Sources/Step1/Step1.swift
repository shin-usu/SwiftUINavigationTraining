import SwiftUI
import Observation
import SwiftUINavigation

@MainActor
@Observable
final class Step1ViewModel {
    @CasePathable
    enum Destination {
        case add(Item)
        case edit(Item)
    }
    
    var destination: Destination?

    func addButtonTapped() {
        destination = .add(.init(title: "Add"))
    }
    
    func editButtonTapped() {
        destination = .edit(.init(title: "Edit"))
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
            .navigationDestination(item: $model.destination.add) { item in
                AddItemView(item: item)
            }
            .navigationDestination(item: $model.destination.edit) { item in
                EditItemView(item: item)
            }
        }
    }
}

#Preview {
    Step1View()
}
