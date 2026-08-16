import Foundation
import SwiftData

@Model
final class JournalEntry {

    var title: String
    var colorHex: String
    var dateCreated: Date
    var content: String

    init(
        title: String,
        colorHex: String = "#007AFF"
    ) {
        self.title = title
        self.colorHex = colorHex
        self.dateCreated = Date()
        self.content = ""
    }
}

