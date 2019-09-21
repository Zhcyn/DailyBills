import UIKit
class LogVC: UIViewController, UITextFieldDelegate {
    let datePicker = UIDatePicker()
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        dateTextField.inputView = datePicker
        amountTextField.delegate = self
        categoryTextField.delegate = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    @IBAction func doneButtonPRessed(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonPressed( sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
