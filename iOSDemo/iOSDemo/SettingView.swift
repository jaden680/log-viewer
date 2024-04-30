import SwiftUI
import Combine
import UBLViewerForIOS

struct SettingView {
    @StateObject var viewModel: SettingViewModel
}

// MARK: - View
extension SettingView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("상태")
                    Spacer()
                    Text(viewModel.stateText)
                    Toggle("", isOn: $viewModel.isToggleOn)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: viewModel.connectionState.color))
                }
            }
            Section {
                HStack {
                    Text("Host")
                    Spacer()
                    TextField("127.0.0.1", text: $viewModel.host)
                        .modifier(InputTextFieldModifier(isDisabled: viewModel.isInputDisabled))
                }
                
                HStack {
                    Text("Port")
                    Spacer()
                    TextField("8080", text: $viewModel.port)
                        .modifier(InputTextFieldModifier(isDisabled: viewModel.isInputDisabled))
                }
            }
        }
        .navigationTitle("설정")
    }
}

private struct InputTextFieldModifier: ViewModifier {
    var isDisabled: Bool

    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
            .opacity(isDisabled ? 0.3 : 1.0)
    }
}

private extension UBLViewerClient.ConnectionState {
    var color: Color {
        switch self {
        case .disconnected:
            return .gray
        case .connecting:
            return .yellow
        case .connected:
            return .green
        }
    }
}

#Preview {
    SettingView(viewModel: .init(client: .init()))
}
