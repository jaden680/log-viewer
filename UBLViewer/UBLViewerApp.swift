import SwiftUI

@main
struct UBLViewerApp: App {
    let serverManager = ServerManager()
    
    var body: some Scene {
        WindowGroup {
            let viewModel = ContentViewModel(serverManager: serverManager)
            ContentView(viewModel: viewModel)
        }
    }
}
