import SwiftUI

struct TodoRow: View {

    var todo: TodoItem

    var body: some View {
        HStack(alignment: .top) {

            Button {
                todo.isCompleted.toggle()
            } label: {
                Image(
                    systemName: todo.isCompleted
                        ? "checkmark.circle.fill"
                        : "circle"
                )
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {

                Text(todo.title)
                    .strikethrough(todo.isCompleted)

                if let deadline = todo.deadline {
                    Label {
                        Text(deadline, format: .dateTime.day().month())
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
        }
    }
}

