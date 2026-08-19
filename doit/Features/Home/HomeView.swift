import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Bullet Journal")
                                .font(.system(size: 40, weight: .bold, design: .rounded))

                            Text(Date.now, format: .dateTime.weekday(.wide).day().month(.wide))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 18)

                        NavigationLink {
                            TodoView()
                        } label: {
                            FeatureCard(
                                title: "To Do",
                                icon: "checkmark.circle.fill",
                                color: .purple
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            JournalView()
                        } label: {
                            FeatureCard(
                                title: "Journal",
                                icon: "book.closed.fill",
                                color: .purple
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            CollectionsView()
                        } label: {
                            FeatureCard(
                                title: "Collections",
                                icon: "rectangle.stack.fill",
                                color: .purple
                            )
                        }
                        .buttonStyle(.plain)
                        NavigationLink {
                            HabitsView()
                        } label: {
                            FeatureCard(
                                title: "Habits",
                                icon: "flame.fill",
                                color: .purple
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 30)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

private struct FeatureCard: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundStyle(color)
                .frame(width: 52)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
            }

            Spacer()

            Image(systemName: "arrow.right")
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
        .padding(22)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(color.opacity(0.09))
        }
    }
}
