import Combine

final class MessageListViewModel: ObservableObject {
    @Published var messageList: [MessageItemViewModel] = []
    
    func append(_ message: Message) {
        let itemViewModel = MessageItemViewModel(message: message)
        messageList.insert(itemViewModel, at: 0)
    }
}
