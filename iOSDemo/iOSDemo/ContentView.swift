import SwiftUI
import UBLViewerForIOS

struct ContentView: View {
    let client: UBLViewerClient
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SettingView(viewModel: .init(client: client))) {
                    Text("설정")
                }
                
                NavigationLink(destination: SendExampleView(client: client)) {
                    Text("샘플")
                }
            }
            .navigationTitle("UBLViewer")
        }
    }
}

#Preview {
    ContentView(client: UBLViewerClient())
}
