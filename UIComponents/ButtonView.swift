
import UIKit
import TransitionButton

class MainButton: TransitionButton {
    
    struct Constants {
        static let cornerRadius: CGFloat = 10.0
    }
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupLayout() {
        layer.masksToBounds = true
        cornerRadius = Constants.cornerRadius
        backgroundColor = Pallete.blueColor
        setTitleColor(.white, for: .normal)
    }
}
