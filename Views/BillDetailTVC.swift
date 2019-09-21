import UIKit
class BillDetailTVC: UITableViewCell {
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var indicatorDot: UILabel!
    var bill: NewBill? {
        didSet {
            updateViews()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateViews(){
        guard let currentBill = bill else { return}
        titleLAbel.text = currentBill.title
        dueDateLabel.text = "\(currentBill.dueDate.asString())"
        amountLabel.text = "$\(currentBill.paymentAmount)"
        if currentBill.isPaid {
            indicatorDot.textColor = #colorLiteral(red: 0, green: 0.8684847951, blue: 0.4671590328, alpha: 1)
        } else {
            indicatorDot.textColor = #colorLiteral(red: 0.8713001609, green: 0.2077551484, blue: 0.2785714269, alpha: 1)
        }
    }
}
