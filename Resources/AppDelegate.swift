import UIKit
let appKey = "a85535fba2e53a23f8a1eb62"
let channel = "Publish channel"
let isProduction = true
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var blockRotation = Bool()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BillsController.shared.loadBills()
        SettingController.shared.loadSettings()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        BillsController.shared.saveBills()
        SettingController.shared.saveSettings()
        NotificationController.shared.removePendingNotificationsfor(bills: BillsController.shared.paidBills)
        let pastdueBillsCount = BillsController.shared.filterBills(by: .isPastDue).count
        let billsDueInFiveDaysCount = BillsController.shared.filterBills(by: .isDueNextWeek).count
        let badgeCount = pastdueBillsCount + billsDueInFiveDaysCount
        UIApplication.shared.applicationIconBadgeNumber = badgeCount
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
         BillsController.shared.saveBills()
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if blockRotation {
            return .allButUpsideDown
        }
        return .portrait
    }
}
