import Foundation
import SwiftData
// Model: tells swiftData to store in db
@Model
final class TodoFolder {
    var title: String
    // Relationship cascade: if folder deleted, delete todos too
    @Relationship(deleteRule: .cascade)
    var todos: [TodoItem] = []

    init(title: String) {
        self.title = title
    }
}
