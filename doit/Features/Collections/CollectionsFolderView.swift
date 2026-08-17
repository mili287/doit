import SwiftUI
import SwiftData

struct CollectionsFolderView: View {

    @Environment(\.modelContext) private var modelContext

    var folder: CollectionFolder

    @State private var showingAddItem = false
    @State private var showingAddSection = false
    @State private var showingManageSections = false

    var body: some View {
        List {

            // Items with no subheading appear at the top without a header.
            if !unsectionedItems.isEmpty {
                ForEach(unsectionedItems) { item in
                    itemRow(item)
                }
                .onDelete(perform: deleteUnsectionedItems)
            }

            ForEach(folder.sections, id: \.self) { section in
                Section {
                    ForEach(items(in: section)) { item in
                        itemRow(item)
                    }
                    .onDelete { offsets in
                        deleteItems(
                            in: section,
                            at: offsets
                        )
                    }
                } header: {
                    Text(section)
                }
            }
        }
        .listStyle(.insetGrouped)
        .contentMargins(.top, 0, for: .scrollContent)
        .navigationTitle(folder.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 10) {

                    // Add item
                    Button {
                        showingAddItem = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 15, weight: .semibold))
                    }

                    // More options
                    Menu {
                        Button {
                            showingAddSection = true
                        } label: {
                            Label(
                                "Add Subheading",
                                systemImage: "text.badge.plus"
                            )
                        }

                        Button {
                            showingManageSections = true
                        } label: {
                            Label(
                                "Manage Subheadings",
                                systemImage: "slider.horizontal.3"
                            )
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 15, weight: .semibold))
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddItem) {
            AddCollectionItemView(folder: folder)
        }
        .sheet(isPresented: $showingAddSection) {
            AddCollectionSectionView(folder: folder)
        }
        .sheet(isPresented: $showingManageSections) {
            ManageCollectionSectionsView(folder: folder)
        }
    }

    @ViewBuilder
    private func itemRow(
        _ item: CollectionItem
    ) -> some View {
        NavigationLink {
            CollectionItemView(
                item: item,
                folder: folder
            )
        } label: {
            HStack(spacing: 14) {
                Image(systemName: "bookmark.fill")
                    .foregroundStyle(
                        Color(hex: folder.colorHex)
                    )
                    .font(.system(size: 20))

                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    Text(item.title)
                        .font(.body)
                        .foregroundStyle(.primary)

                    if let rating = item.rating {
                        Text(ratingText(rating))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()
            }
        }
    }

    private var unsectionedItems: [CollectionItem] {
        folder.items
            .filter { $0.section.isEmpty }
            .sorted { $0.dateCreated < $1.dateCreated }
    }

    private func items(
        in section: String
    ) -> [CollectionItem] {
        let filteredItems = folder.items.filter {
            $0.section == section
        }

        return filteredItems.sorted {
            $0.dateCreated < $1.dateCreated
        }
    }

    private func deleteUnsectionedItems(
        at offsets: IndexSet
    ) {
        for index in offsets {
            modelContext.delete(unsectionedItems[index])
        }

        saveContext()
    }

    private func deleteItems(
        in section: String,
        at offsets: IndexSet
    ) {
        let sectionItems = items(in: section)

        for index in offsets {
            modelContext.delete(sectionItems[index])
        }

        saveContext()
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save collection changes: \(error)")
        }
    }

    private func ratingText(
        _ rating: Int
    ) -> String {
        String(
            repeating: "★",
            count: rating
        )
    }
}
