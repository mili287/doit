import SwiftUI
import SwiftData

struct HabitsView: View {

    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Habit.title)
    private var habits: [Habit]

    @State private var showingAddHabit = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                if habits.isEmpty {
                    ContentUnavailableView(
                        "No Habits Yet",
                        systemImage: "chart.bar.fill",
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(habits) { habit in
                                HabitRow(habit: habit)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView()
            }
            .onAppear {
                for habit in habits {
                    habit.resetIfNeeded()
                }
            }
        }
    }
}
