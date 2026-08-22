import Foundation
import SwiftData

@Model
final class HabitRecord {

    var date: Date
    var amount: Int
    var targetAmount: Int

    var habit: Habit?

    init(
        date: Date = .now,
        amount: Int,
        targetAmount: Int,
        habit: Habit? = nil
    ) {
        self.date = date
        self.amount = amount
        self.targetAmount = targetAmount
        self.habit = habit
    }

    var percentage: Double {
        guard targetAmount > 0 else { return 0 }

        return Double(amount) / Double(targetAmount)
    }

    var wasCompleted: Bool {
        amount >= targetAmount
    }
}
