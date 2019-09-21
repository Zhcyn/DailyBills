import Foundation
enum BillFrequency: String, CaseIterable {
    case none = "One Time Payment"
    case weekly = "Weekly Payment"
    case biweekly = "Biweekly Payment"
    case monthly = "Monthly Payment"
    case quarterly = "Quarterly Payment"
    case semiAnual = "Semi Anual Payment"
    case anual = "Anual Payment"
}
