import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Bullet Journal")
                    .font(.largeTitle)
                    .bold()

                NavigationLink {
                    TodoView()
                } label: {
                    Text("ToDo List")
                }

            }
            .padding()  
        }
    }
}

#Preview {
    HomeView()
}

