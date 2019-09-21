import UIKit
protocol MainBillCustomCellDelegate: class{
    func billIsPaidToggle(cell: MainViewTableViewCell)
}
class MainViewTableViewCell: UITableViewCell {
    var bill: NewBill? {
        didSet {
            updateViews()
        }
    }
    var cellDelegate: MainBillCustomCellDelegate?
    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var isPaidButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func isPaidButtonPressed(_ sender: Any) {
        cellDelegate?.billIsPaidToggle(cell: self)
        updateViews()
    }
    func updateViews(){
        guard let bill = bill else {return}
        billTitle.text = bill.title
        dueDateLabel.text = "\(bill.dueDate.dayAndMonthAsString())"
        if bill.isPaid {
            isPaidButtonOutlet.setImage(#imageLiteral(resourceName: "Paid"), for: .normal)
        } else {
            isPaidButtonOutlet.setImage(#imageLiteral(resourceName: "UnPaid"), for: .normal)
        }
    }
}
