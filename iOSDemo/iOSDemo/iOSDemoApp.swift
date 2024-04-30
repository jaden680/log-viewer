import SwiftUI
import UBLViewerForIOS

@main
struct iOSDemoApp: App {
    let client = UBLViewerClient()
    var body: some Scene {
        WindowGroup {
            ContentView(client: client)
        }
    }
}
