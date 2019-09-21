import Foundation
class LogController {
    static var shared  = LogController()
    private init() {}
    var logs = [Log]()
    func createLogWith(category: String, amount: Double, date: Date?){
        let log = Log(category: category, amount: amount, date: date)
        logs.append(log)
    }
}
