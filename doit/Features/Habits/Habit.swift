import Foundation
import SwiftData

enum HabitResetFrequency: String, Codable, CaseIterable, Identifiable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"

    var id: String { rawValue }
}

@Model
final class Habit {
    
    var title: String
    var amount: Int
    var targetAmount: Int
    var resetFrequencyRawValue: String
    var lastResetDate: Date
    
    init(
        title: String = "",
        amount: Int = 0,
        targetAmount: Int = 1,
        resetFrequency: HabitResetFrequency = .daily,
        lastResetDate: Date = .now
    ) {
        self.title = title
        self.amount = amount
        self.targetAmount = targetAmount
        self.resetFrequencyRawValue = resetFrequency.rawValue
        self.lastResetDate = lastResetDate
    }
    
    var percentage: Double {
        guard targetAmount > 0 else { return 0 }

        return Double(amount) / Double(targetAmount)
    }
    
    var isCompleted: Bool {
        amount >= targetAmount
    }
    
    var resetFrequency: HabitResetFrequency {
        get {
            HabitResetFrequency(
                rawValue: resetFrequencyRawValue
            ) ?? .daily
        }
        set {
            resetFrequencyRawValue = newValue.rawValue
        }
    }
    
    func resetIfNeeded() {
        
        let calendar = Calendar.current
        let now = Date()
        
        let shouldReset: Bool
        
        switch resetFrequency {
            
        case .daily:
            shouldReset = !calendar.isDate(
                lastResetDate,
                inSameDayAs: now
            )
            
        case .weekly:
            shouldReset = !calendar.isDate(
                lastResetDate,
                equalTo: now,
                toGranularity: .weekOfYear
            )
            
        case .monthly:
            shouldReset = !calendar.isDate(
                lastResetDate,
                equalTo: now,
                toGranularity: .month
            )
            
            if shouldReset {
                amount = 0
                lastResetDate = now
            }
        }
    }
}
