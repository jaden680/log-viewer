import Foundation
import Network

protocol TCPServerDelegate: AnyObject {
    func didReceive(message: String)
}

final class TCPServer {
    var listener: NWListener?
    
    weak var delegate: TCPServerDelegate?

    func start() {
        do {
            // NWListener를 TCP 프로토콜과 특정 포트를 사용하여 생성
            self.listener = try NWListener(using: .tcp, on: 8080)
        } catch {
            print("Unable to create listener")
            return
        }

        // 새로운 연결을 처리하는 핸들러
        self.listener?.newConnectionHandler = { connection in
            connection.start(queue: .main)
            self.receive(on: connection)
        }

        // 리스너 시작
        self.listener?.start(queue: .main)
        print("Server started on port 8080")
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
