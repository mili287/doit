import SwiftUI
import SwiftData

struct AddHabitView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Habit") {
                    TextField("Habit name", text: $title)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addHabit()
                    }
                    .disabled(
                        title
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .isEmpty
                    )
                }
            }
        }
    }

    private func addHabit() {
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let habit = Habit(
            title: cleanTitle
        )


        modelContext.insert(habit)

        dismiss()
    }
}
