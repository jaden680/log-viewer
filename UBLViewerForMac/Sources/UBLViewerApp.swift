import SwiftUI

let serverManager = ServerManager()

@main
struct UBLViewerApp: App {
//    @AppStorage("UBLViewer.port") private var port: String = "3000"
    private var port: String = "8080"
    
    var body: some Scene {
        WindowGroup {
            let viewModel = ContentViewModel(serverManager: serverManager)
            ContentView(viewModel: viewModel)
                .onAppear(perform: {
                    serverManager.startServer(port: port)
                })
                .onChange(of: port) { oldValue, newValue in
//                    if oldValue != newValue {
//                        serverManager.startServer(port: newValue)
//                    }
                }
        }
        
        Settings {
            SettingView()
        }
    }
}
