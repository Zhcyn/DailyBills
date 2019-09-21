import UIKit
import UserNotifications
class BillsTableViewController: UITableViewController, BillCustomCellDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = #imageLiteral(resourceName: "Billy background")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        let label = UILabel()
        label.textColor = .white
        label.frame = CGRect(x: 30, y: 10, width: 400, height: 40)
        view.addSubview(label)
        switch section {
        case 0:
            label.text = "Past Due"
        case 1:
            label.text = "Due this week"
        case 2:
            label.text =  "Due next week"
        case 3:
            label.text =  "Due this month"
        case 4:
            label.text =  "Paid"
        case 5:
            label.text =  "Other Bills"
        default:
            label.text =  "Not a valid section"
        }
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return BillsController.shared.filterBills(by: .isPastDue).count
        case 1:
            return BillsController.shared.filterBills(by: .isDueNextWeek).count
        case 2:
            return BillsController.shared.filterBills(by: .isDueInTwoWeeks).count
        case 3:
            return BillsController.shared.filterBills(by: .isDueThisMonth).count
        case 4:
            return BillsController.shared.filterBills(by: .isPaid).count
        case 5:
            return BillsController.shared.filterBills(by: .otherBills).count
        default: return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BillCustomCell else {return UITableViewCell()}
        cell.cellDelegate = self
        switch indexPath.section {
        case 0:
           cell.bill = BillsController.shared.filterBills(by: .isPastDue)[indexPath.row]
        case 1:
            cell.bill = BillsController.shared.filterBills(by: .isDueNextWeek)[indexPath.row]
        case 2:
            cell.bill = BillsController.shared.filterBills(by: .isDueInTwoWeeks)[indexPath.row]
        case 3:
            cell.bill = BillsController.shared.filterBills(by: .isDueThisMonth)[indexPath.row]
        case 4:
            cell.bill = BillsController.shared.filterBills(by: .isPaid)[indexPath.row]
        case 5:
            cell.bill = BillsController.shared.filterBills(by: .otherBills)[indexPath.row]
        default:
            cell.bill = nil
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var bill : NewBill?
            switch indexPath.section {
            case 0:
                bill = BillsController.shared.filterBills(by: .isPastDue)[indexPath.row]
            case 1:
                bill = BillsController.shared.filterBills(by: .isDueNextWeek)[indexPath.row]
            case 2:
                bill = BillsController.shared.filterBills(by: .isDueInTwoWeeks)[indexPath.row]
            case 3:
                bill = BillsController.shared.filterBills(by: .isDueThisMonth)[indexPath.row]
            case 4:
                bill = BillsController.shared.filterBills(by: .isPaid)[indexPath.row]
            case 5:
                bill = BillsController.shared.filterBills(by: .otherBills)[indexPath.row]
            default:
                bill = nil
            }
        }
    }
    func billHasBeenPaidToggle(cell: BillCustomCell) {
        guard let bill = cell.bill else {return}
        guard let indexOfBill = BillsController.shared.bills.index(of: bill) else {return}
        BillsController.shared.bills[indexOfBill].isPaid.toggle()
        tableView.reloadData()
    }
}
