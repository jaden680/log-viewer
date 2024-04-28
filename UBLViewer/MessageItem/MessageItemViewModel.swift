import Foundation
import Combine

final class MessageItemViewModel: ObservableObject, Identifiable {
    @Published var type: String
    @Published var text: String
    
    let message: Message
    
    init(message: Message) {
        self.message = message
        
        type = self.message.type.rawValue
        text = self.message.raw
    }
}
