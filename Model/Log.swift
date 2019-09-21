import Foundation
class Log {
    var category: String
    var amount: Double
    var date: Date?
    init(category: String, amount: Double, date: Date? = Date()){
        self.category = category
        self.amount = amount
        self.date = date
    }
}
