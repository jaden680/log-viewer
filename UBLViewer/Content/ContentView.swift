import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            MessageListView(viewModel: viewModel.listViewModel)
        }
        .padding()
        .onAppear(perform: {
            viewModel.startServer()
        })
    }
}
