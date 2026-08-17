import SwiftUI
import SwiftData

struct CollectionItemView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let item: CollectionItem
    let folder: CollectionFolder

    @State private var title: String
    @State private var selectedSection: String
    @State private var rating: Int?
    @State private var notes: String

    init(
        item: CollectionItem,
        folder: CollectionFolder
    ) {
        self.item = item
        self.folder = folder

        _title = State(initialValue: item.title)
        _selectedSection = State(initialValue: item.section)
        _rating = State(initialValue: item.rating)
        _notes = State(initialValue: item.notes)
    }

    var body: some View {
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

                if rating != nil {
                    Button("Remove Rating", role: .destructive) {
                        rating = nil
                    }
                }
            }

            Section("Notes") {
                TextEditor(text: $notes)
                    .frame(minHeight: 180)
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveChanges()
                }
                .fontWeight(.semibold)
                .disabled(
                    title.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                )
            }
        }
    }

    private func saveChanges() {
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanTitle.isEmpty else { return }

        item.title = cleanTitle
        item.section = selectedSection
        item.rating = rating
        item.notes = notes

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save collection item: \(error)")
        }
    }
}

