import Foundation
import Combine
import Network

final class ServerManager: ObservableObject, TCPServerDelegate {
    let messagePublisher = PassthroughSubject<String, Never>()
    
    private var server: TCPServer?
    
    init() {
        // nothing
    }
    
    func stopServer() {
        server?.stop()
    }

    func startServer(port: String) {
        stopServer()
        
        server = TCPServer(port: port)
        server?.delegate = self
        server?.start()
    }
    
    func didReceive(message: String) {
        messagePublisher.send(message)
    }
    
    func getCurrentIPAddressWithPort() -> String? {
        guard let server else { return nil }
        
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else {
                    return nil
                }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    guard let ifa_name = interface.ifa_name else {
                        return nil
                    }
                    let name: String = String(cString: ifa_name)
                    
                    if name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                    
                }
            }
            freeifaddrs(ifaddr)
        }
        return (address ?? "") + ":\(server.port)"
    }
}
