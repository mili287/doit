import SwiftUI
import SwiftData

struct TodoView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var folders: [TodoFolder]
    
    @State private var showingAddFolder = false
    
    var body: some View {
        
        List {
            ForEach(folders) { folder in
                NavigationLink {
                    TodoFolderView(folder: folder)
                } label: {
                    HStack {
                        Image(systemName: "folder.fill")
                            .foregroundStyle(Color(hex: folder.colorHex))
                        
                        Text(folder.title)
                        
                        Spacer()
                        
                        Text("\(folder.todos.count)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onDelete(perform: deleteFolders)
        }
        .listStyle(.insetGrouped)
        .contentMargins(.top, 0, for: .scrollContent)
        
        .navigationTitle("ToDo")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddFolder = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .semibold))
                }
            }
        }
        
        .sheet(isPresented: $showingAddFolder) {
            AddFolderView()
        }
    }
    
    private func deleteFolders(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(folders[index])
        }
    }
}
