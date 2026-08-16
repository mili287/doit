import Foundation
import SwiftData

@Model
final class TodoFolder {

    var title: String
    var colorHex: String

    @Relationship(deleteRule: .cascade)
    var todos: [TodoItem] = []

    init(
        title: String,
        colorHex: String = "#007AFF"
    ) {
        self.title = title
        self.colorHex = colorHex
    }
}
