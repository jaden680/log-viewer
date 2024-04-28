import Foundation
import Combine

final class ServerManager: ObservableObject, TCPServerDelegate {
    let messagePublisher = PassthroughSubject<String, Never>()
    
    private var server: TCPServer?
    
    init(server: TCPServer? = nil) {
        self.server = server ?? TCPServer()
        self.server?.delegate = self
    }

    func startServer() {
        server?.start()
    }
    
    func didReceive(message: String) {
        messagePublisher.send(message)
    }
}
