import SwiftUI

struct HabitRow: View {

    @Bindable var habit: Habit

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack {
                Text(habit.title)
                    .font(.headline)

                Spacer()

                Text("\(Int(habit.percentage * 100))%")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: habit.percentage)
                .progressViewStyle(.linear)

            HStack {
                Text("\(habit.amount)")
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()

                Button {
                    decreaseProgress()
                } label: {
                    Image(systemName: "minus")
                        .frame(width: 36, height: 36)
                        .background(Color(.secondarySystemGroupedBackground))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                Button {
                    increaseProgress()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 36, height: 36)
                        .background(Color.accentColor.opacity(0.15))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func increaseProgress() {
        habit.amount += 1

        habit.isCompleted = habit.percentage >= 1
    }

    private func decreaseProgress() {
        guard habit.amount > 0 else { return }

        habit.amount -= 1

        habit.isCompleted = false
    }
}
