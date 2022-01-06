import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: HelloWorld()
                ) {
                    HStack {
                        Text("HelloWorld")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
