import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    @State var selection: UBLMessage.ID? = nil
    
    var body: some View {
        VSplitView {
            UBLListView(ublList: viewModel.ublList, selection: $selection)
                
            
            HStack {
                Text("Test")
                Spacer()
            }
            
            HSplitView {
                UBLDetailView(item: viewModel.selectedUBL)
                EmptyView()
                
            }
        }
        .onChange(of: selection) { oldValue, newValue in
            viewModel.didSelectUBL(id: newValue)
        }
    }
}
