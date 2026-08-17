import SwiftUI
import SwiftData

struct AddCollectionItemView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var folder: CollectionFolder

    @State private var title = ""
    @State private var selectedSection = ""
    @State private var rating: Int?

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Title", text: $title)

                    Picker("Subheading", selection: $selectedSection) {
                        Text("No Subheading")
                            .tag("")

                        ForEach(folder.sections, id: \.self) { section in
                            Text(section)
                                .tag(section)
                        }
                    }
                }

                Section("Rating") {
                    HStack(spacing: 12) {
                        ForEach(1...5, id: \.self) { star in
                            Button {
                                rating = rating == star ? nil : star
                            } label: {
                                Image(
                                    systemName: star <= (rating ?? 0)
                                        ? "star.fill"
                                        : "star"
                                )
                                .font(.title2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addItem()
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

    private func addItem() {
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanTitle.isEmpty else { return }

        let item = CollectionItem(
            title: cleanTitle,
            colorHex: folder.colorHex,
            rating: rating,
            section: selectedSection
        )

        folder.items.append(item)
        modelContext.insert(item)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save collection item: \(error)")
        }
    }
}
