import SwiftUI

struct MessageItemView: View {
    @StateObject var viewModel: MessageItemViewModel
    
    var body: some View {
        LazyHStack(content: {
            Text(viewModel.message.raw)
            Text(viewModel.text)
            Text(viewModel.text)
            Text(viewModel.text)
        })
    }
}
