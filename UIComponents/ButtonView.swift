
import UIKit

class MyButton: UIButton {
    
    struct Constants {
        static let cornerRadius: CGFloat = 10.0
    }
    
    init() {
        super.init(frame: .zero)
        layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Pallete.blueColor
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
