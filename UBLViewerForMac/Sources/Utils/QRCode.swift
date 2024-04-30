import SwiftUI
import CoreImage

extension String {
    func generateQRCodeImage() -> Image? {
        guard let data = self.data(using: .ascii) else {
            return nil
        }
        
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("Q", forKey: "inputCorrectionLevel") // Error correction level
        
        guard let qrImage = qrFilter.outputImage else {
            return nil
        }
        
        let scaleX = 200 / qrImage.extent.size.width
        let scaleY = 200 / qrImage.extent.size.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let scaledQrImage = qrImage.transformed(by: transform)
        
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(scaledQrImage, from: scaledQrImage.extent) else {
            return nil
        }
        
        let image = Image(cgImage, scale: 1.0, label: Text(self))
        
        return image
    }
}
