import Foundation
import SwiftData

@Model
final class CollectionItem {

    var title: String
    var colorHex: String
    var rating: Int?
    var section: String
    var dateCreated: Date
    var notes: String

    init(
        title: String,
        colorHex: String = "#007AFF",
        rating: Int? = nil,
        section: String = "Unsorted",
        notes: String = ""
    ) {
        self.title = title
        self.colorHex = colorHex
        self.rating = rating
        self.section = section
        self.dateCreated = Date()
        self.notes = notes
    }
}
