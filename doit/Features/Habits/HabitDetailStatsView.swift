import SwiftUI
import Charts

struct HabitDetailStatsView: View {

    let habit: Habit

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                statsOverview

                VStack(alignment: .leading, spacing: 12) {
                    Text("Progress")
                        .font(.title2)
                        .fontWeight(.bold)

                    Chart(sortedRecords) { record in
                        BarMark(
                            x: .value("Date", record.date),
                            y: .value("Amount", record.amount)
                        )
                        .foregroundStyle(
                            record.wasCompleted
                            ? Color.green
                            : Color.accentColor
                        )
                    }
                    .frame(height: 220)
                }
            }
            .padding()
        }
        .navigationTitle(habit.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var sortedRecords: [HabitRecord] {
        habit.records.sorted {
            $0.date < $1.date
        }
    }

    private var statsOverview: some View {
        VStack(spacing: 12) {

            statRow(
                title: "Completion Rate",
                value: "\(completionRate)%"
            )

            statRow(
                title: "Average",
                value: String(format: "%.1f", averageAmount)
            )

            statRow(
                title: "Best",
                value: "\(bestAmount)"
            )
        }
    }

    private func statRow(
        title: String,
        value: String
    ) -> some View {

        HStack {
            Text(title)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
        }
    }

    private var completionRate: Int {

        guard !habit.records.isEmpty else {
            return 0
        }

        let completed = habit.records.filter {
            $0.wasCompleted
        }.count

        return Int(
            Double(completed) /
            Double(habit.records.count) *
            100
        )
    }

    private var averageAmount: Double {

        guard !habit.records.isEmpty else {
            return 0
        }

        let total = habit.records.reduce(0) {
            $0 + $1.amount
        }

        return Double(total) /
               Double(habit.records.count)
    }

    private var bestAmount: Int {
        habit.records
            .map(\.amount)
            .max() ?? 0
    }
}
