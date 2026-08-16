import SwiftUI
import SwiftData

struct JournalEntryView: View {

    @Bindable var entry: JournalEntry

    var body: some View {
        TextEditor(text: $entry.content)
            .font(.body)
            .padding(.horizontal)
            .padding(.top, 8)
            .scrollContentBackground(.hidden)
            .background(Color(.systemBackground))
            .navigationTitle(entry.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
