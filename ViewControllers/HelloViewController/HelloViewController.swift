
import UIKit
import SnapKit

class HelloViewController: UIViewController, UITextFieldDelegate {
    
    private let headerView: UIImageView = {
        let header = UIImageView()
        header.clipsToBounds = true
        header.contentMode = .scaleAspectFit
        header.image = UIImage(named: "urban")
        return header
    }()

    let inputField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите количество игроков..."
        field.layer.masksToBounds = true
        field.returnKeyType = .next
        field.keyboardType = UIKeyboardType.numberPad
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.layer.cornerRadius = 10
        field.backgroundColor = Pallete.lightGray
        field.text = ""
        return field
    }()
    
    let switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Сделать игру интересней?"
        label.font = UIFont(name:"STHeitiTC-Light", size: 20.0)
        return label
    }()
    
    let switchServer: UISwitch = {
        let switchServ = UISwitch(frame:CGRect(x: 150, y: 300, width: 0, height: 0))
        switchServ.onTintColor  = Pallete.blueColor
        return switchServ
    }()
    
    let buttonToBegin: MyButton = {
        let button = MyButton()
        button.setTitle("Начать", for: .normal)
        return button
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Передумал", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        title = "Я не робот"
        addSubviews()
        layoutConstraints()
        buttonToBegin.addTarget(self,
                                action: #selector(handleShowNext),
                                for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(inputField)
        view.addSubview(buttonToBegin)
        view.addSubview(switchServer)
        view.addSubview(switchLabel)
    }

    func layoutConstraints() {
        headerView.snp.makeConstraints {
            $0.height.equalTo(500)
            $0.width.equalTo(300)
            $0.centerY.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        inputField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalTo(view.snp.left).offset(30)
            $0.right.equalTo(view.snp.right).offset(-30)
            $0.height.equalTo(50)
        }
        switchLabel.snp.makeConstraints {
            $0.top.equalTo(inputField.snp.bottom).offset(20)
            $0.left.equalTo(view.snp.left).offset(34)
        }
        switchServer.snp.makeConstraints {
            $0.top.equalTo(inputField.snp.bottom).offset(20)
            $0.right.equalTo(view.snp.right).offset(-33)
        }
        buttonToBegin.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.left.equalTo(view.snp.left).offset(16)
            $0.right.equalTo(view.snp.right).offset(-16)
            $0.height.equalTo(50)
        }
    }
    
    @objc func handleTap() {
        inputField.resignFirstResponder()
    }
    
    @objc func handleShowNext() {
        let vc = GameViewController()
        guard let numbor = (inputField.text)?.description.toInt() else
        {return}
        vc.numberOfPlayers = numbor
        vc.isGameWithServer = switchServer.isOn
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension String {
    //Converts String to Int
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
}


