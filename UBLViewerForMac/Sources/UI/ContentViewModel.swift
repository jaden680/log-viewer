import Combine

final class ContentViewModel: ObservableObject {
    private let serverManager: ServerManager
    private var cancellables = Set<AnyCancellable>()
    
    @Published var ublList: [UBLMessage] = []
    @Published var selectedUBL: UBLMessage?
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
        
        bind()
    }
    
    private func bind() {
        serverManager.messagePublisher
            .compactMap { message in
                UBLMessage(message)
            }
            .sink(receiveValue: { [weak self] message in
                self?.ublList.append(message)
            })
            .store(in: &cancellables)
    }
    
    func didSelectUBL(id: UBLMessage.ID?) {
        selectedUBL = if let id {
            ublList.first { $0.id == id }
        } else {
            nil
        }
    }
}
