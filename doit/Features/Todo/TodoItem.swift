import Foundation
import SwiftData

@Model
final class TodoItem {

    var title: String
    var isCompleted: Bool
    var dueDate: Date?

    init(
        title: String = "",
        isCompleted: Bool = false,
        dueDate: Date? = nil
    ) {
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
}
