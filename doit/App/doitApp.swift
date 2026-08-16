import SwiftUI
import SwiftData

@main
struct DigitalBulletJournalApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [
            TodoFolder.self,
            TodoItem.self,
            JournalEntry.self
        ])
    }
}
