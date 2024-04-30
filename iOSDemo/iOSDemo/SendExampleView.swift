import SwiftUI
import UBLViewerForIOS

struct SendExampleView: View {
    let client: UBLViewerClient
    
    var body: some View {
        VStack {
            
            Button {
                let sampleData: [String: Any] = [
                    "category": "pageview",
                    "navigation": "sample_page",
                    "object_id": "object_id",
                    "object_idx": 1,
                    "object_section": "object_section",
                    "data": [
                        "data_value": "value"
                    ]
                ]
                client.send(sampleData)
            } label: {
                Text("전송")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    SendExampleView(client: .init())
}
