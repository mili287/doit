import Foundation
import SwiftData

@Model
final class Habit {

    var title: String
    var isCompleted: Bool
    var amount: Int
    var targetAmount: Int

    init(
        title: String = "",
        isCompleted: Bool = false,
        amount: Int = 0,
        targetAmount: Int = 10
    ) {
        self.title = title
        self.isCompleted = isCompleted
        self.amount = amount
        self.targetAmount = targetAmount
    }

    var percentage: Double {
        guard targetAmount > 0 else { return 0 }

        return min(
            Double(amount) / Double(targetAmount),
            1.0
        )
    }
}
