import SwiftUI

extension UBLCategory {
    var backgroundColor: Color {
        switch self {
        case .pageview:
            return Color(red: 0.9, green: 0.9, blue: 0.95)
        case .ptr:
            return Color(red: 0.95, green: 0.95, blue: 0.9)
        case .click:
            return Color(red: 0.95, green: 0.9, blue: 0.9)
        case .impression:
            return Color(red: 0.9, green: 0.95, blue: 0.9)
        case .save_product:
            return Color(red: 0.85, green: 0.85, blue: 0.95)
        case .remove_saved_product:
            return Color(red: 0.95, green: 0.85, blue: 0.85)
        case .add_bookmark:
            return Color(red: 0.85, green: 0.95, blue: 0.85)
        case .remove_bookmark:
            return Color(red: 0.8, green: 0.9, blue: 0.95)
        case .complete_meta_purchase:
            return Color(red: 0.95, green: 0.8, blue: 0.8)
        case .deeplink:
            return Color(red: 0.8, green: 0.95, blue: 0.9)
        case .group:
            return Color(red: 0.75, green: 0.85, blue: 0.95)
        case .tti:
            return Color(red: 0.7, green: 0.9, blue: 0.9)
        case .add_to_cart:
            return Color(red: 0.65, green: 0.75, blue: 0.85)
        case .remove_from_cart:
            return Color(red: 0.9, green: 0.7, blue: 0.7)
        case .complete_zpay_purchase:
            return Color(red: 0.6, green: 0.7, blue: 0.8)
        case .search:
            return Color(red: 0.8, green: 0.7, blue: 0.75)
        case .unknown:
            return Color.gray
        }
    }
    
    var textColor: Color {
        return Color.black
    }
}
