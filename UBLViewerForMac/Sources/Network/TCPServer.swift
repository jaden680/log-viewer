import Foundation
import Network

protocol TCPServerDelegate: AnyObject {
    func didReceive(message: String)
}

final class TCPServer {
    var listener: NWListener?
    let port: String
    
    weak var delegate: TCPServerDelegate?
    
    init(port: String) {
        self.port = port
    }

    func start() {
        guard let port = NWEndpoint.Port(port) else { return }
        
        do {
            self.listener = try NWListener(using: .tcp, on: port)
        } catch {
            print("Unable to create listener")
            return
        }

        self.listener?.newConnectionHandler = { connection in
            connection.start(queue: .main)
            self.receive(on: connection)
        }

        self.listener?.start(queue: .main)
        print("Server started on port \(port)")
    }
    
    func stop() {
        listener?.cancel()
        listener?.newConnectionHandler = nil
        listener = nil
    }

    func receive(on connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { [weak self] data, _, isComplete, error in
            guard let self else { return }
            
            if let data = data, let message = String(data: data, encoding: .utf8) {
                print("Received: \(message)")
                self.send(response: "Echo: \(message)", on: connection)
                
                delegate?.didReceive(message: message)
            }
            
            if isComplete || error != nil {
                connection.cancel()
            } else {
                self.receive(on: connection) // Continue receiving
            }
        }
    }

    func send(response: String, on connection: NWConnection) {
        let data = Data(response.utf8)
        connection.send(content: data, completion: .contentProcessed({ error in
            if let error = error {
                print("Send error: \(error)")
                return
            }
            print("Message was sent")
        }))
    }
}
