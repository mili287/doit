import SwiftUI
import SwiftData

struct AddEntryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var selectedColor = Color.blue
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Entry") {
                    TextField("Name", text: $title)
                }
                
                Section("Color") {
                    ColorPicker(
                        "Entry Color",
                        selection: $selectedColor,
                        supportsOpacity: false
                    )
                }
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addEntry()
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
    
    private func addEntry() {
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !cleanTitle.isEmpty else { return }
        
        let entry = JournalEntry(
            title: cleanTitle,
            colorHex: selectedColor.toHex()
        )
        
        modelContext.insert(entry)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save entry: \(error)")
        }
    }
}

