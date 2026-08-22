import SwiftUI
import SwiftData

struct HabitsView: View {

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
                        description: Text(
                            "Add a habit to start tracking your progress."
                        )
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(habits) { habit in
                                NavigationLink {
                                    HabitDetailStatsView(
                                        habit: habit
                                    )
                                } label: {
                                    HabitRow(
                                        habit: habit
                                    )
                                }
                                .buttonStyle(.plain)
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
