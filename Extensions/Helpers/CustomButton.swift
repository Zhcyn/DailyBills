import UIKit
class CustomButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = .clear
        self.setTitleShadowColor(.darkGray, for: .normal)
        self.setTitleColor(.white, for: .normal)
    }
}
extension UIButton {
    func hapticFeedback(){
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
