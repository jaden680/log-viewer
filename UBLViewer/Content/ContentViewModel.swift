import Combine

final class ContentViewModel: ObservableObject {
    let listViewModel = MessageListViewModel()
    
    private let serverManager: ServerManager
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
        
        bind()
    }
    
    func startServer() {
        serverManager.startServer()
    }
    
    private func bind() {
        serverManager.messagePublisher
            .map { message in
                Message(type: .system, raw: message)
            }
            .sink(receiveValue: { [weak self] message in
                self?.listViewModel.append(message)
            })
            .store(in: &cancellables)
    }
}
