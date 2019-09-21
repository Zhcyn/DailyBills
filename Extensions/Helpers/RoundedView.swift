import UIKit
class RoundedView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 9
    }
}
