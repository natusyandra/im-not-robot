
import SwiftUI

@available(iOS 14.0, *)

class LanchScreenController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mySwiftUIView = RouletteText()
        
        let hostingController = UIHostingController(rootView: mySwiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        
        timeToOpenHelloViewController()
    }
    
    func openHelloViewController() {
        let vc = HelloViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func timeToOpenHelloViewController() {
        let delay : Double = 3.6
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.openHelloViewController()
        }
    }
}
