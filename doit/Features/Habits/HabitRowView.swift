import SwiftUI

struct HabitRow: View {

    @Bindable var habit: Habit

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack {

                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.title)
                        .font(.headline)

                    Text(
                        "\(habit.amount) of \(habit.targetAmount)"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                Spacer()

                if habit.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(.title2)
                } else {
                    Text("\(Int(habit.percentage * 100))%")
                        .font(.subheadline)
                        .foregroundStyle(
                            habit.isCompleted ? .green : .secondary
                        )
                }
            }

            ProgressView(
                value: min(habit.percentage, 1.0)
            )
            .tint(
                habit.isCompleted ? .green : .accentColor
            )

            HStack {

                Text(habit.resetFrequency.rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Button {
                    decreaseProgress()
                } label: {
                    Image(systemName: "minus")
                        .frame(width: 36, height: 36)
                        .background(
                            Color(.tertiarySystemGroupedBackground)
                        )
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                Button {
                    increaseProgress()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 36, height: 36)
                        .background(
                            habit.isCompleted
                            ? Color.green.opacity(0.15)
                            : Color.accentColor.opacity(0.15)
                        )
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(
            habit.isCompleted
            ? Color.green.opacity(0.12)
            : Color(.secondarySystemGroupedBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }

    private func increaseProgress() {
        habit.amount += 1
    }

    private func decreaseProgress() {
        guard habit.amount > 0 else {
            return
        }

        habit.amount -= 1
    }
}
