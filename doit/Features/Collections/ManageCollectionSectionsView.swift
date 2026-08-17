import SwiftUI
import SwiftData

struct ManageCollectionSectionsView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var folder: CollectionFolder

    var body: some View {
        NavigationStack {
            List {
                if folder.sections.isEmpty {
                    ContentUnavailableView(
                        "No Subheadings",
                        systemImage: "text.alignleft",
                        description: Text(
                            "Add a subheading from the collection page."
                        )
                    )
                } else {
                    ForEach(folder.sections, id: \.self) { section in
                        Text(section)
                    }
                    .onDelete(perform: deleteSections)
                }
            }
            .navigationTitle("Subheadings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func deleteSections(at offsets: IndexSet) {
        let sectionsToDelete = offsets.map {
            folder.sections[$0]
        }

        for section in sectionsToDelete {
            // Keep the items, but remove their subheading.
            for item in folder.items where item.section == section {
                item.section = ""
            }
        }

        folder.sections.remove(atOffsets: offsets)

        do {
            try modelContext.save()
        } catch {
            print("Failed to delete subheading: \(error)")
        }
    }
}
