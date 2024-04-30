import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    func toJSONString(prettyPrinted: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        
        let options: JSONSerialization.WritingOptions = prettyPrinted ? .prettyPrinted : []
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }

        return String(data: jsonData, encoding: .utf8)
    }
}
