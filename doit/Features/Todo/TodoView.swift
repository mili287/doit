import SwiftUI
import SwiftData

struct TodoView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var folders: [TodoFolder]

    @State private var newFolderTitle = ""

    var body: some View {
        List {

            // Existing folders
            ForEach(folders) { folder in
                NavigationLink {
                    TodoFolderView(folder: folder)
                } label: {
                    HStack {
                        Image(systemName: "folder")

                        Text(folder.title)

                        Spacer()

                        Text("\(folder.todos.count)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onDelete(perform: deleteFolders)

            // Add a new folder
            HStack {
                Image(systemName: "plus")
                    .foregroundStyle(.secondary)

                TextField("New list...", text: $newFolderTitle)
                    .onSubmit {
                        addFolder()
                    }
            }
        }
        .navigationTitle("To-Do")
    }

    private func addFolder() {
        let title = newFolderTitle.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !title.isEmpty else { return }

        modelContext.insert(
            TodoFolder(title: title)
        )

        newFolderTitle = ""
    }

    private func deleteFolders(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(folders[index])
        }
    }
}
