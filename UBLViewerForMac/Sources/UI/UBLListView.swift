import SwiftUI

struct UBLListView: View {
    var ublList: [UBLMessage]
    @Binding var selection: UBLMessage.ID?
    
    var body: some View {
        Table(ublList, selection: $selection) {
            TableColumn("Navigation") { ubl in
                Text(ubl.navigation)
            }
            TableColumn("Navigation Sub") { ubl in
                Text(ubl.navigationSub?.toJSONString() ?? "")
            }
            TableColumn("Time") { ubl in
                Text(ubl.dateText)
            }
            TableColumn("Object Section") { ubl in
                Text(ubl.objectSection)
            }
            TableColumn("Object ID") { ubl in
                Text(ubl.objectId)
            }
            TableColumn("Object Idx") { ubl in
                Text(ubl.objectIdx.description)
            }
            TableColumn("Object URL") { ubl in
                Text(ubl.objectURL)
            }
            TableColumn("Data") { ubl in
                Text(ubl.data?.toJSONString() ?? "")
            }
        }
        .tableStyle(.bordered)
    }
}

#Preview {
    @State var selection: UBLMessage.ID?
    let list: [UBLMessage] = [
        .init(raw: "", navigation: "navigations", navigationSub: [:], clientAccessTime: 10231321, objectId: "", objectIdx: 0, category: .click, objectURL: "ubl", objectSection: "section", data: [:]),
        .init(raw: "", navigation: "navigations", navigationSub: [:], clientAccessTime: 10231321, objectId: "", objectIdx: 0, category: .click, objectURL: "ubl", objectSection: "section", data: [:]),
        .init(raw: "", navigation: "navigations", navigationSub: [:], clientAccessTime: 10231321, objectId: "", objectIdx: 0, category: .click, objectURL: "ubl", objectSection: "section", data: [:]),
        .init(raw: "", navigation: "navigations", navigationSub: [:], clientAccessTime: 10231321, objectId: "", objectIdx: 0, category: .click, objectURL: "ubl", objectSection: "section", data: [:]),
        .init(raw: "", navigation: "navigations", navigationSub: [:], clientAccessTime: 10231321, objectId: "", objectIdx: 0, category: .click, objectURL: "ubl", objectSection: "section", data: [:])
    ]
    return UBLListView(ublList: list, selection: $selection)
}
