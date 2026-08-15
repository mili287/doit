import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String
    var isCompleted: Bool
    var deadline: Date?

    init(
        title: String,
        isCompleted: Bool = false,
        deadline: Date? = nil
    ) {
        self.title = title
        self.isCompleted = isCompleted
        self.deadline = deadline
    }
}
