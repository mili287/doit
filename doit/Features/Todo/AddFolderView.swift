import SwiftUI
import SwiftData

struct AddFolderView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var selectedColor = Color.blue

    var body: some View {
        NavigationStack {
            Form {
                Section("Folder") {
                    TextField("Folder name", text: $title)
                }

                Section("Color") {
                    ColorPicker(
                        "Folder Color",
                        selection: $selectedColor,
                        supportsOpacity: false
                    )
                }
            }
            .navigationTitle("New Folder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addFolder()
                    }
                    .disabled(
                        title.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
            }
        }
    }

    private func addFolder() {
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanTitle.isEmpty else { return }

        let folder = TodoFolder(
            title: cleanTitle,
            colorHex: selectedColor.toHex()
        )

        modelContext.insert(folder)

        dismiss()
    }
}
