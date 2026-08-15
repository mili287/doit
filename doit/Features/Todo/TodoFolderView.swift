import SwiftUI
import SwiftData

struct TodoFolderView: View {

    @Environment(\.modelContext) private var modelContext

    var folder: TodoFolder

    @State private var newTodoTitle = ""
    @State private var hasDeadline = false
    @State private var newTodoDeadline = Date()

    var body: some View {
        VStack {

            List {

                // Existing todos
                ForEach(folder.todos) { todo in
                    TodoRow(todo: todo)
                }
                .onDelete(perform: deleteTodos)

                // New todo
                Section {
                    TextField("Add task...", text: $newTodoTitle)

                    Toggle("Deadline", isOn: $hasDeadline)

                    if hasDeadline {
                        DatePicker(
                            "Due",
                            selection: $newTodoDeadline,
                            displayedComponents: .date
                        )
                    }

                    Button("Done") {
                        addTodo()
                    }
                    .disabled(newTodoTitle.isEmpty)
                }
            }
        }
        .navigationTitle(folder.title)
    }

    private func addTodo() {
        let title = newTodoTitle.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !title.isEmpty else { return }

        let todo = TodoItem(
            title: title,
            deadline: hasDeadline ? newTodoDeadline : nil
        )

        folder.todos.append(todo)

        newTodoTitle = ""
        hasDeadline = false
        newTodoDeadline = Date()
    }

    private func deleteTodos(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(folder.todos[index])
        }
    }
}
