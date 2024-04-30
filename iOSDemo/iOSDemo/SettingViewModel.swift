import Foundation
import SwiftUI
import Combine
import UBLViewerForIOS

final class SettingViewModel: ObservableObject {
    typealias ConnectionState = UBLViewerClient.ConnectionState
    
    @Published var connectionState: ConnectionState
    @Published var isToggleOn: Bool = false
    @Published var stateText: String = ""
    @Published var host: String = "127.0.0.1"
    @Published var port: String = "8080"
    
    var isInputDisabled: Bool {
        connectionState != .disconnected
    }
    
    let client: UBLViewerClient
    private var cancellables = Set<AnyCancellable>()
    
    init(client: UBLViewerClient) {
        self.client = client
        
        connectionState = client.connectionState
        
        client.stateHandler = { [weak self] state in
            print("hieh : \(state)")
            self?.connectionState = state
        }
        
        bind()
    }
    
    private func bind() {
        $connectionState
            .removeDuplicates()
            .map { $0 != .disconnected }
            .assign(to: &$isToggleOn)
        
        $connectionState
            .removeDuplicates()
            .map {
                switch $0 {
                case .disconnected:
                    return "연결 안됨"
                case .connecting:
                    return "연결중"
                case .connected:
                    return "연결됨"
                }
            }
            .assign(to: &$stateText)
        
        $isToggleOn
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] isOn in
                guard let self else { return }
                
                if isOn {
                    client.start(host: host, port: Int(port) ?? 0)
                } else {
                    client.stop()
                }
            }
            .store(in: &cancellables)
        
        $host
            .dropFirst()
            .map { Self.formatAsIPAddress($0) }
            .assign(to: &$host)
    }
}

private extension SettingViewModel {
    static func formatAsIPAddress(_ text: String) -> String {
        var formattedText = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var components = [String]()
        
        while formattedText.count > 0 {
            let prefix = String(formattedText.prefix(3))
            components.append(prefix)
            formattedText = String(formattedText.dropFirst(3))
        }
        
        let formatted = components.joined(separator: ".")
        return formatted.trimmingCharacters(in: CharacterSet(charactersIn: "."))
    }
}
