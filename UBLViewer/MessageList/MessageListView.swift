import SwiftUI

struct MessageListView: View {
    @StateObject var viewModel: MessageListViewModel
    
    var body: some View {
        List(viewModel.messageList) { itemViewModel in
            MessageItemView(viewModel: itemViewModel)
        }
    }
}
