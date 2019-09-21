import UIKit
class BillTableViewCell: UITableViewCell {
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dotLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func billIsCompletedButtonTapped(_ sender: Any) {
    }
}
