import SwiftUI

private extension UBLDetailView{
    struct ContentType: Identifiable {
        let id: UUID
        let key: String
        let value: String
        
        init(id: UUID = UUID(), key: String, value: String) {
            self.id = id
            self.key = key
            self.value = value
        }
    }
}

struct UBLDetailView: View {
    var item: UBLMessage?
    
    var body: some View {
        VStack {
            if let item {
                Table(of: ContentType.self) {
                    TableColumn("Key") { data in
                        Text(data.key)
                            .lineLimit(nil)
                        Spacer()
                    }
                    .width(max: 200)
                    
                    TableColumn("Value") { data in
                        Text(data.value)
                            .lineLimit(nil)
                        Spacer()
                    }
                } rows: {
                    
                    TableRow(ContentType(key: "Navigation", value: item.navigation))
                    TableRow(ContentType(key: "Navigation Sub", value: item.navigationSub?.toJSONString() ?? ""))
                    TableRow(ContentType(key: "Object Section", value: item.objectSection))
                    TableRow(ContentType(key: "Object ID", value: item.objectId))
                    TableRow(ContentType(key: "Object idx", value: item.objectIdx.description))
                    TableRow(ContentType(key: "Object URL", value: item.objectURL))
                    TableRow(ContentType(key: "Data", value: item.data?.toJSONString() ?? ""))
                    TableRow(ContentType(key: "Client Access Time", value: item.dateText))
                    
                }
                .scrollContentBackground(.hidden)
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    UBLDetailView(item:
            .init(
                raw: "",
                navigation: "navigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigationsnavigations",
                navigationSub: [:],
                clientAccessTime: 10231321,
                objectId: "",
                objectIdx: 0,
                category: .click,
                objectURL: "ubl",
                objectSection: "section",
                data: [:]
            )
    )
}
