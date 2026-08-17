import SwiftUI
import SwiftData

struct AddCollectionSectionView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var folder: CollectionFolder

    @State private var title = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Subheading") {
                    TextField("Name", text: $title)
                }
            }
            .navigationTitle("New Subheading")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addSection()
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

    private func addSection() {
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanTitle.isEmpty else { return }

        let alreadyExists = folder.sections.contains {
            $0.caseInsensitiveCompare(cleanTitle) == .orderedSame
        }

        guard !alreadyExists else { return }

        folder.sections.append(cleanTitle)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save section: \(error)")
        }
    }
}
