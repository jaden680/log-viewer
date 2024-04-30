import Network
import Foundation

public extension UBLViewerClient {
    enum ConnectionState {
        case disconnected, connecting, connected
    }
}

public final class UBLViewerClient {
    public private(set) var connectionState: ConnectionState = .disconnected
    
    public var connection: NWConnection?
    
    public var host: NWEndpoint.Host?
    public var port: NWEndpoint.Port?
    
    public var stateHandler: ((ConnectionState) -> ())?
    public var sendHandler: ((Error?) -> ())?
    public var receiveHandler: ((String, Error?) -> ())?
    
    public init() {
        // nothing
    }
    
    private func setup(host hostValue: String, port portValue: Int) {
        stop()
        
        host = NWEndpoint.Host(hostValue)
        port = NWEndpoint.Port(rawValue: UInt16(portValue)) ?? 8080
        
        guard let host, let port else { return }
        
        connection = NWConnection(host: host, port: port, using: .tcp)
        connection?.stateUpdateHandler = { [weak self] (state: NWConnection.State) in
            guard let self else { return }
            
            print(state)
            switch state {
            case .setup, .preparing:
                connectionState = .connecting
            case .ready:
                connectionState = .connected
            case .waiting, .failed, .cancelled:
                connectionState = .disconnected
                stop()
            @unknown default:
                connectionState = .disconnected
                stop()
            }
            
            stateHandler?(connectionState)
        }
    }
    
    public func stop() {
        connection?.stateUpdateHandler = nil
        connection?.cancel()
        connection = nil
        connectionState = .disconnected
        stateHandler?(connectionState)
    }

    public func start(host: String, port: Int) {
        setup(host: host, port: port)
        connection?.start(queue: .main)
    }

    public func send(_ data: [String: Any]) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        
        let data = Data(jsonData)
        connection?.send(content: data, completion: .contentProcessed({ [weak self] error in
            self?.sendHandler?(error)
            self?.receive()
        }))
    }

    public func receive() {
        connection?.receive(minimumIncompleteLength: 1, maximumLength: 65536) { [weak self] data, _, _, error in
            if let data, let message = String(data: data, encoding: .utf8) {
                self?.receiveHandler?(message, error)
            }
        }
    }
}
