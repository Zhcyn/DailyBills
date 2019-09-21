import UIKit
protocol BillCustomCellDelegate: class{
    func billHasBeenPaidToggle(cell: BillCustomCell)
}
class BillCustomCell: UITableViewCell {
    @IBOutlet weak var billNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var isPaidButton: UIButton!
    @IBOutlet weak var amoutLabel: UILabel!
    var bill: NewBill? {
        didSet {
            updateViews()
        }
    }
    var cellDelegate: BillCustomCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        isPaidButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateViews() {
        guard let bill = bill else {return}
        billNameLabel.text = bill.title
        dueDateLabel.text = bill.dueDate.asString()
        amoutLabel.text = String(bill.paymentAmount)
        if bill.isPaid {
            isPaidButton.setImage(#imageLiteral(resourceName: "Paid"), for: .normal)
        } else {
            isPaidButton.setImage(#imageLiteral(resourceName: "UnPaid"), for: .normal)
        }
    }
    @IBAction func isPaidButtonTapped(_ sender: Any) {
        cellDelegate?.billHasBeenPaidToggle(cell: self)
    }
}
