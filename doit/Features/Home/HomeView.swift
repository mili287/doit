import SwiftUI
import SwiftData

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {

                        // Header
                        Text("Bullet Journal")
                            .font(.system(size: 38, weight: .bold, design: .rounded))
                            .padding(.top, 20)
                            .padding(.bottom, 8)

                        // To-Do Card
                        NavigationLink {
                            TodoView()
                        } label: {
                            HStack(spacing: 18) {

                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(.blue.opacity(0.15))
                                        .frame(width: 58, height: 58)

                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 28))
                                        .foregroundStyle(.blue)
                                }

                                Text("To Do")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(20)
                            .background {
                                RoundedRectangle(cornerRadius: 26)
                                    .fill(.background)
                                    .shadow(
                                        color: .black.opacity(0.06),
                                        radius: 12,
                                        y: 5
                                    )
                            }
                        }
                        .buttonStyle(.plain)

                        // Journal Card
                        NavigationLink {
                            JournalView()
                        } label: {
                            HStack(spacing: 18) {

                                ZStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(.purple.opacity(0.15))
                                        .frame(width: 58, height: 58)

                                    Image(systemName: "book.closed.fill")
                                        .font(.system(size: 28))
                                        .foregroundStyle(.purple)
                                }

                                Text("Journal")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(20)
                            .background {
                                RoundedRectangle(cornerRadius: 26)
                                    .fill(.background)
                                    .shadow(
                                        color: .black.opacity(0.06),
                                        radius: 12,
                                        y: 5
                                    )
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 22)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(
            for: [
                TodoFolder.self,
                TodoItem.self,
                JournalEntry.self
            ],
            inMemory: true
        )
}
