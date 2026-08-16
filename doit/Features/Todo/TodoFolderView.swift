import SwiftUI
import SwiftData

struct TodoFolderView: View {

    @Environment(\.modelContext) private var modelContext

    var folder: TodoFolder

    var body: some View {
        List {
            ForEach(folder.todos) { todo in
                TodoRow(todo: todo) {
                    deleteTodo(todo)
                }
            }
            .onDelete(perform: deleteTodos)

            Button {
                addTodo()
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "plus.circle.fill")
                    Text("New Task")
                }
            }
        }
        .navigationTitle(folder.title)
    }

    private func addTodo() {
        let hasEmptyTask = folder.todos.contains { todo in
            todo.title
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
        }

        guard !hasEmptyTask else { return }

        let todo = TodoItem(
            title: "",
            isCompleted: false,
            dueDate: nil
        )

        folder.todos.append(todo)
        modelContext.insert(todo)
    }

    private func deleteTodo(_ todo: TodoItem) {
        guard let index = folder.todos.firstIndex(
            where: { $0.persistentModelID == todo.persistentModelID }
        ) else {
            return
        }

        folder.todos.remove(at: index)
        modelContext.delete(todo)
    }

    private func deleteTodos(at offsets: IndexSet) {
        let todosToDelete = offsets.map { folder.todos[$0] }

        for todo in todosToDelete {
            deleteTodo(todo)
        }
    }
}
