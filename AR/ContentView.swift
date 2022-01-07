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
                NavigationLink(
                    destination: SetInTable()
                ) {
                    HStack {
                        Text("机へのオブジェクト設置")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                NavigationLink(
                    destination: SetInImage()
                ) {
                    HStack {
                        Text("画像へのオブジェクト設置")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                NavigationLink(
                    destination: SetInCup()
                ) {
                    HStack {
                        Text("コップへのオブジェクト設置")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                NavigationLink(
                    destination: Animation()
                ) {
                    HStack {
                        Text("オブジェクトのアニメーション")
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
