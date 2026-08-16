import SwiftUI
import SwiftData

struct TodoDatePicker: View {

    @Bindable var todo: TodoItem

    @Environment(\.dismiss) private var dismiss

    @State private var selectedDate = Date()

    var body: some View {
        VStack(spacing: 16) {

            DatePicker(
                "Due Date",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)

            HStack {
                if todo.dueDate != nil {
                    Button("Remove Date", role: .destructive) {
                        todo.dueDate = nil
                        dismiss()
                    }
                }

                Spacer()

                Button("Done") {
                    todo.dueDate = selectedDate
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(width: 340)
        .onAppear {
            selectedDate = todo.dueDate ?? Date()
        }
    }
}
