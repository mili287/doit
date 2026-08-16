import SwiftUI
import SwiftData

struct TodoRow: View {

    @Bindable var todo: TodoItem

    let onDelete: () -> Void

    @FocusState private var titleIsFocused: Bool
    @State private var showingDatePicker = false

    var body: some View {
        HStack(spacing: 12) {

            Button {
                guard !cleanTitle.isEmpty else { return }
                todo.isCompleted.toggle()
            } label: {
                Image(
                    systemName:
                        todo.isCompleted
                        ? "checkmark.circle.fill"
                        : "circle"
                )
                .font(.title3)
                .foregroundStyle(
                    todo.isCompleted
                    ? Color.gray
                    : Color.secondary
                )
            }
            .buttonStyle(.plain)
            .disabled(cleanTitle.isEmpty)

            VStack(alignment: .leading, spacing: 3) {

                TextField("Task", text: $todo.title)
                    .focused($titleIsFocused)
                    .strikethrough(todo.isCompleted)
                    .foregroundStyle(
                        todo.isCompleted
                        ? Color.secondary
                        : Color.primary
                    )
                    .onSubmit {
                        titleIsFocused = false
                    }

                if let dueDate = todo.dueDate {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption2)

                        Text(dueDateText(dueDate))
                            .font(.caption)
                    }
                    .foregroundStyle(dueDateColor(dueDate))
                }
            }

            Spacer()

            Button {
                guard !cleanTitle.isEmpty else { return }
                showingDatePicker.toggle()
            } label: {
                Image(
                    systemName:
                        todo.dueDate == nil
                        ? "calendar"
                        : "calendar.badge.clock"
                )
                .font(.title3)
                .foregroundStyle(
                    todo.isCompleted
                    ? Color.gray
                    : todo.dueDate == nil
                        ? Color.secondary
                        : Color.blue
                )
            }
            .buttonStyle(.plain)
            .disabled(cleanTitle.isEmpty)
            .popover(isPresented: $showingDatePicker) {
                TodoDatePicker(todo: todo)
                    .presentationCompactAdaptation(.popover)
            }
        }
        .padding(.vertical, 5)
        .onAppear {
            if cleanTitle.isEmpty {
                titleIsFocused = true
            }
        }
        .onChange(of: todo.title) { _, newValue in
            let trimmed = newValue.trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            if trimmed.isEmpty {
                todo.isCompleted = false
            }
        }
        
        .onChange(of: titleIsFocused) { _, isFocused in
            if !isFocused && cleanTitle.isEmpty {
                onDelete()
            }
        }
        

            
    }

    private var cleanTitle: String {
        todo.title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }

    private func dueDateColor(_ date: Date) -> Color {
        if todo.isCompleted {
            return .gray
        }

        let calendar = Calendar.current

        if calendar.startOfDay(for: date) <
            calendar.startOfDay(for: Date()) {
            return .red
        }

        return .green
    }

    private func dueDateText(_ date: Date) -> String {
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        }

        if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        }

        return date.formatted(
            .dateTime
                .day()
                .month(.abbreviated)
        )
    }
}
