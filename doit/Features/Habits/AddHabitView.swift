import SwiftUI
import SwiftData

struct AddHabitView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var targetAmount = 1
    @State private var resetFrequency: HabitResetFrequency = .daily

    var body: some View {
        NavigationStack {
            Form {

                Section("Habit") {
                    TextField("Habit name", text: $title)
                }

                Section("Goal") {
                    Stepper(
                        "Target: \(targetAmount)",
                        value: $targetAmount,
                        in: 1...100
                    )
                }

                Section("Reset") {
                    Picker(
                        "Reset habit",
                        selection: $resetFrequency
                    ) {
                        ForEach(HabitResetFrequency.allCases) { frequency in
                            Text(frequency.rawValue)
                                .tag(frequency)
                        }
                    }
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
                            .trimmingCharacters(
                                in: .whitespacesAndNewlines
                            )
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
            title: cleanTitle,
            targetAmount: targetAmount,
            resetFrequency: resetFrequency
        )

        modelContext.insert(habit)

        dismiss()
    }
}
