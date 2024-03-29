import UIKit
import UserNotifications
class TemporaryNotificationTVC: UITableViewController {
    let center = UNUserNotificationCenter.current()
    var pendingNotifications = [UNNotificationRequest](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var deliveredNotifications = [UNNotification](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        center.getPendingNotificationRequests(completionHandler: { (pendingNot) in
            self.pendingNotifications = pendingNot
        })
        center.getDeliveredNotifications { (delivered) in
            self.deliveredNotifications = delivered
        }
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return pendingNotifications.count
        case 1: return deliveredNotifications.count
        default: return 0
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Pending"
        case 1: return "Delivered"
        default: return "Error"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temporaryCell", for: indexPath)
        switch indexPath.section {
        case 0: cell.textLabel?.text = pendingNotifications[indexPath.row].content.title
        cell.detailTextLabel?.text = "\(pendingNotifications[indexPath.row].content.body), \(pendingNotifications[indexPath.row].trigger.debugDescription)"
        case 1: cell.textLabel?.text = deliveredNotifications[indexPath.row].request.content.title
        cell.detailTextLabel?.text = deliveredNotifications[indexPath.row].request.content.body
        default: cell.textLabel?.text = "Error"
        }
        return cell
    }
}
