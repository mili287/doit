import SwiftUI
import SwiftData

struct HabitStatsView: View {

    @Query(sort: \Habit.title)
    private var habits: [Habit]

    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    NavigationLink {
                        HabitDetailStatsView(habit: habit)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {

                            Text(habit.title)
                                .font(.headline)

                            HStack {
                                Text("Completed")

                                Spacer()

                                Text("\(completionPercentage(for: habit))%")
                                    .foregroundStyle(.secondary)
                            }
                            .font(.subheadline)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Statistics")
        }
    }

    private func completionPercentage(for habit: Habit) -> Int {

        guard !habit.records.isEmpty else {
            return 0
        }

        let completed = habit.records.filter {
            $0.wasCompleted
        }.count

        let percentage =
            Double(completed) /
            Double(habit.records.count) *
            100

        return Int(percentage)
    }
}
