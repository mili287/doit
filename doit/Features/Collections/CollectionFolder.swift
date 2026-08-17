import Foundation
import SwiftData

@Model
final class CollectionFolder {

    var title: String
    var colorHex: String
    var sections: [String]

    @Relationship(deleteRule: .cascade)
    var items: [CollectionItem] = []

    init(
        title: String,
        colorHex: String = "#007AFF",
        sections: [String] = []
    ) {
        self.title = title
        self.colorHex = colorHex
        self.sections = sections
    }
}
