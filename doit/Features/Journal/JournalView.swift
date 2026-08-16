import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [JournalEntry]
    @State private var showingAddEntry = false

    var body: some View {
        List {
            ForEach(entries) { entry in
                NavigationLink {
                    JournalEntryView(entry: entry)
                } label: {
                    HStack(spacing: 14) {

                        Image(systemName: "book.closed.fill")
                            .foregroundStyle(Color(hex: entry.colorHex))
                            .font(.system(size: 20))

                        VStack(alignment: .leading, spacing: 4) {
                            Text(entry.title)
                                .font(.body)
                                .foregroundStyle(.primary)

                            Text(
                                entry.dateCreated,
                                format: .dateTime
                                    .day()
                                    .month(.abbreviated)
                                    .year()
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                }
            }
            .onDelete(perform: deleteEntries)
        }
        .listStyle(.insetGrouped)
        .contentMargins(.top, 0, for: .scrollContent)
        .navigationTitle("Journal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddEntry = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .semibold))
                }
            }
        }
        .sheet(isPresented: $showingAddEntry) {
            AddEntryView()
        }
    }

    private func deleteEntries(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(entries[index])
        }
    }
}
