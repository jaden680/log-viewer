import SwiftUI
import Combine

struct SettingView: View {
    @AppStorage("UBLViewer.port") private var storedPort: String = "8080"
    @State private var port: String = ""
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        List {
            Form {
                HStack(content: {
                    Spacer()
                    Text("Port")
                    TextField("", text: $port)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: port) { _, newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue, !filtered.isEmpty {
                                self.port = filtered
                                self.storedPort = filtered
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                    Spacer()
                })
            }
            .padding()

        }
        .navigationTitle("Settings")
        .onAppear(perform: {
            self.port = self.storedPort
            
            self.cancellable = port.publisher
                .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                .sink { newValue in
                    self.storedPort = String(newValue)
                }
        })
        .onDisappear {
            self.cancellable?.cancel()
        }
    }
}

#Preview {
    SettingView()
}
