import Foundation

enum UBLCategory: CaseIterable {
    static var allCases: [UBLCategory] {
        [
            .pageview,
            .ptr,
            .click,
            .impression,
            .save_product,
            .remove_saved_product,
            .add_bookmark,
            .remove_bookmark,
            .complete_meta_purchase,
            .deeplink,
            .group,
            .tti,
            .add_to_cart,
            .remove_from_cart,
            .complete_zpay_purchase,
            .search,
        ]
    }
    
    typealias RawValue = String
    
    case pageview
    case ptr
    case click
    case impression
    case save_product
    case remove_saved_product
    case add_bookmark
    case remove_bookmark
    case complete_meta_purchase
    case deeplink
    case group
    case tti
    case add_to_cart
    case remove_from_cart
    case complete_zpay_purchase
    case search
    case unknown(String)
    
    var rawValue: RawValue {
        switch self {
        case .pageview:
            return "pageview"
        case .ptr:
            return "ptr"
        case .click:
            return "click"
        case .impression:
            return "impression"
        case .save_product:
            return "save_product"
        case .remove_saved_product:
            return "remove_saved_product"
        case .add_bookmark:
            return "add_bookmark"
        case .remove_bookmark:
            return "remove_bookmark"
        case .complete_meta_purchase:
            return "complete_meta_purchase"
        case .deeplink:
            return "deeplink"
        case .group:
            return "group"
        case .tti:
            return "tti"
        case .add_to_cart:
            return "add_to_cart"
        case .remove_from_cart:
            return "remove_from_cart"
        case .complete_zpay_purchase:
            return "complete_zpay_purchase"
        case .search:
            return "search"
        case .unknown(let string):
            return string
        }
    }
    
    init(raw: String) {
        switch raw {
        case "pageview":
            self = .pageview
        case "ptr":
            self = .ptr
        case "click":
            self = .click
        case "impression":
            self = .impression
        case "save_product":
            self = .save_product
        case "remove_saved_product":
            self = .remove_saved_product
        case "add_bookmark":
            self = .add_bookmark
        case "remove_bookmark":
            self = .remove_bookmark
        case "complete_meta_purchase":
            self = .complete_meta_purchase
        case "deeplink":
            self = .deeplink
        case "group":
            self = .group
        case "tti":
            self = .tti
        case "add_to_cart":
            self = .add_to_cart
        case "remove_from_cart":
            self = .remove_from_cart
        case "complete_zpay_purchase":
            self = .complete_zpay_purchase
        case "search":
            self = .search
        default:
            self = .unknown(raw)
        }
    }
}

struct UBLMessage: Identifiable {
    let id: UUID = UUID()
    let raw: String
    
    let navigation: String
    let navigationSub: [String: Any]?
    let clientAccessTime: Int
    let objectId: String
    let objectIdx: Int
    let category: UBLCategory
    let objectURL: String
    let objectSection: String
    let data: [String: Any]?
    
    var dateText: String {
        let date = Date(timeIntervalSince1970: TimeInterval(clientAccessTime) / 1000)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM/dd HH:mm:ss.SSS"
        return formatter.string(from: date)
    }
    
    init(raw: String, navigation: String, navigationSub: [String : Any]?, clientAccessTime: Int, objectId: String, objectIdx: Int, category: UBLCategory, objectURL: String, objectSection: String, data: [String : Any]?) {
        self.raw = raw
        self.navigation = navigation
        self.navigationSub = navigationSub
        self.clientAccessTime = clientAccessTime
        self.objectId = objectId
        self.objectIdx = objectIdx
        self.category = category
        self.objectURL = objectURL
        self.objectSection = objectSection
        self.data = data
    }
    
    init?(_ raw: String) {
        self.raw = raw
        guard  let data = raw.data(using: .utf8) else { return nil }
            
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                self.clientAccessTime = json["client_access_time"] as? Int ?? 0
                self.navigation = json["navigation"] as? String ?? ""
                self.navigationSub = json["navigation_sub"] as? [String: Any]
                self.objectId = json["object_id"] as? String ?? ""
                self.objectIdx = json["object_idx"] as? Int ?? 0
                self.category = UBLCategory(raw: (json["category"] as? String ?? ""))
                self.objectURL = json["object_url"] as? String ?? ""
                self.objectSection = json["object_section"] as? String ?? ""
                self.data = json["data"] as? [String: Any]
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
