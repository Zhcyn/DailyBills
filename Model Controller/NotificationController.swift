import UIKit
import UserNotifications
class NotificationController {
    static let shared = NotificationController()
    private init() {}
    var nonitifcationIdentyfiers: [String] = []
    var permissionGranted = false
    func checkNotificationPermision() -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (granted, error) in
            if granted {
                print("✅ Notification access Granted")
                self.permissionGranted = true
                SettingController.shared.initialLaunch = false
            } else {
                print("❌ Notification access Denied")
                self.permissionGranted = false
            }
            if let error = error {
                print("❌ Error during notification request authorization \(error.localizedDescription)")
            }
        }
        print("❔ Permision status: \(permissionGranted)")
        return permissionGranted
    }
    func setupNotificationWith(bill: NewBill){
        var title = ""
        let center = UNUserNotificationCenter.current()
        if checkNotificationPermision() == false {
            return
        }
        let content = UNMutableNotificationContent()
        SettingController.shared.checkNotificationStates()
        for notification in SettingController.shared.notificationState {
            switch notification {
            case .custom:
                print("1️⃣ Creating custom notification")
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
                dateComponents.day! -= SettingController.shared.setting.dayDelay
                dateComponents.hour = SettingController.shared.setting.notificationTime?.hour().hour ?? 8
                dateComponents.minute = SettingController.shared.setting.notificationTime?.hour().min ?? 30
                if SettingController.shared.setting.dayDelay == 1 {
                    title =  "\(bill.title) payment is due in \(SettingController.shared.setting.dayDelay) day."
                } else {
                    title =  "\(bill.title) payment is due in \(SettingController.shared.setting.dayDelay) days."
                }
                content.badge = 1
                content.title = title
                content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.asString())."
                content.sound = .default
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(identifier: bill.notificationIdentyfier[0], content: content, trigger: trigger)
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                    } else {
                        print("💜 Notification with title: \(title) added.")
                        print("💜 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                        print("💜 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                    }
                }
                print("1️⃣ Finished custom notification 🔐")
            case .onADueDate:
                print("2️⃣ Creating notification on due date")
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
                dateComponents.day! -= 0
                dateComponents.hour = SettingController.shared.setting.notificationTime?.hour().hour ?? 8
                dateComponents.minute =  SettingController.shared.setting.notificationTime?.hour().min ?? 30
                title =  "\(bill.title) payment is due today!"
                content.badge = 1
                content.title = title
                content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.dayAndMonthAsString())."
                content.sound = .default
                let customIdentyfier : String = bill.notificationIdentyfier[1]
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                    } else {
                        print("💛 Notification with title: \(title) added.")
                        print("💛 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                        print("💛 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                    }
                }
                print("2️⃣ Finished onDueDate notification 🔐")
            case .twoDaysBefore:
                print("3️⃣ Creating notification two daye before")
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
                dateComponents.day! -= 2
                dateComponents.hour = SettingController.shared.setting.notificationTime?.hour().hour ?? 8
                dateComponents.minute = SettingController.shared.setting.notificationTime?.hour().min ?? 30
                title =  "\(bill.title) payment is due in 2 days"
                content.badge = 1
                content.title = title
                content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.dayAndMonthAsString())."
                content.sound = .default
                let customIdentyfier : String = bill.notificationIdentyfier[2]
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
                center.add(request) { (error) in
                    if let error = error {
                        print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                    } else {
                        print("💙 Notification with title: \(title) added.")
                        print("💙 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                        print("💙 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                    }
                }
                print("3️⃣ Finished TWODayeBefore notification 🔐")
            }
        }
    }
    func removeNotificationFor(bill: NewBill){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: bill.notificationIdentyfier)
    }
    func setupNotificationWith2(bill: NewBill){
        var title = ""
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        if checkNotificationPermision() == false {
            return
        }
        print("1️⃣ Creating custom notification")
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
        dateComponents.day! -= bill.setting.dayDelay
        dateComponents.hour = bill.setting.notificationTime?.hour().hour
        dateComponents.minute = bill.setting.notificationTime?.hour().min
        if bill.setting.dayDelay == 1 {
            title = "\(bill.title) payment is due in \( bill.setting.dayDelay) day."
        } else {
            title = "\(bill.title) payment is due in \(bill.setting.dayDelay) days."
        }
        content.badge = 1
        content.title = title
        content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.asString())."
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: bill.notificationIdentyfier[0], content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
            } else {
                print("💜 Notification with title: \(title) added.")
                print("💜 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                print("💜 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
            }
        }
        print("1️⃣ Finished custom notification 🔐")
        if bill.setting.notifyOnDay == true {
            print("2️⃣ Creating notification on due date")
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
            dateComponents.day! -= 0
            dateComponents.hour = bill.setting.notificationTime?.hour().hour
            dateComponents.minute = bill.setting.notificationTime?.hour().min
            title =  "\(bill.title) payment is due today!"
            content.badge = 1
            content.title = title
            content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.dayAndMonthAsString())."
            content.sound = .default
            let customIdentyfier : String = bill.notificationIdentyfier[1]
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
            center.add(request) { (error) in
                if let error = error {
                    print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                } else {
                    print("💛 Notification with title: \(title) added.")
                    print("💛 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                    print("💛 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                }
            }
            print("2️⃣ Finished onDueDate notification 🔐")
        }
        if bill.setting.notifyTwoDaysBefore == true {
            print("3️⃣ Creating notification two daye before")
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: bill.dueDate)
            dateComponents.day! -= 2
            dateComponents.hour =  bill.setting.notificationTime?.hour().hour
            dateComponents.minute =  bill.setting.notificationTime?.hour().min
            title =  "\(bill.title) payment is due in 2 days"
            content.badge = 1
            content.title = title
            content.body = "A Payment of \(bill.paymentAmount) is due on \(bill.dueDate.dayAndMonthAsString())."
            content.sound = .default
            let customIdentyfier : String = bill.notificationIdentyfier[2]
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: customIdentyfier, content: content, trigger: trigger)
            center.add(request) { (error) in
                if let error = error {
                    print("📵 Error Creating Notification for title: \(title), ERROR: \(error.localizedDescription)")
                } else {
                    print("💙 Notification with title: \(title) added.")
                    print("💙 MY Settings: \n dateComponents: \(dateComponents.debugDescription), \n billDueData \(bill.dueDate.debugDescription)")
                    print("💙 Notification options:  \n title: \(request.content.title) \n body: \(request.content.body) \n identyfier: \(request.identifier), \n trigger: \(request.trigger.debugDescription))")
                }
            }
            print("3️⃣ Finished TWODayeBefore notification 🔐")
        }
    }
    func removePendingNotificationsfor(bills: Set<NewBill>){
        let center = UNUserNotificationCenter.current()
        for bill in bills {
            center.removePendingNotificationRequests(withIdentifiers: bill.notificationIdentyfier)
        }
    }
}
