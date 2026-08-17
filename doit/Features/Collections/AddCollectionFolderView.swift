import SwiftUI
import SwiftData

struct AddCollectionFolderView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var selectedColor = Color.orange

    var body: some View {
        NavigationStack {
            Form {
                Section("Collection") {
                    TextField("Name", text: $title)
                }

                Section("Color") {
                    ColorPicker(
                        "Collection Color",
                        selection: $selectedColor,
                        supportsOpacity: false
                    )
                }
            }
            .navigationTitle("New Collection")
            .navigationBarTitleDisplayMode(.inline)
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

        let folder = CollectionFolder(
            title: cleanTitle,
            colorHex: selectedColor.toHex()
        )

        modelContext.insert(folder)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save collection folder: \(error)")
        }
    }
}
