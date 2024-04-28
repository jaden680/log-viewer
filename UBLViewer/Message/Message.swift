import Foundation

enum MessageType: String {
    case system
    case ubl
}

struct Message: Identifiable {
    let id: UUID = UUID()
    let type: MessageType
    let raw: String
    
    
    init(type: MessageType, raw: String) {
        self.type = type
        self.raw = raw
    }
}

struct UBLMessage: Identifiable {
    let id: UUID = UUID()
    let type: MessageType
    let raw: String
    
    init(type: MessageType, raw: String) {
        self.type = type
        self.raw = raw
    }
}
