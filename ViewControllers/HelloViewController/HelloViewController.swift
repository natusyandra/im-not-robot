
import UIKit
import SnapKit
import AnimatedField

class HelloViewController: UIViewController, UITextFieldDelegate {
    
    private let headerView: UIImageView = {
        let header = UIImageView()
        header.clipsToBounds = true
        header.contentMode = .scaleAspectFit
        header.image = UIImage(named: "urban")
        return header
    }()
    
    let inputField: AnimatedField = {
        let field = AnimatedField()
        field.attributedPlaceholder = NSAttributedString(string: "Введите количество игроков...", attributes:[.foregroundColor: UIColor.lightGray])
        field.keyboardType = .numberPad
        field.format.titleAlwaysVisible = false
        field.format.lineColor = UIColor.lightGray
        field.format.titleColor = UIColor.lightGray
        field.format.textColor = UIColor.darkGray
        field.format.highlightColor = .lightGray

        return field
    }()
    
    let switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Сделать игру интересней"
        label.font = UIFont(name:"STHeitiTC-Light", size: 18.0)
        return label
    }()
    
    let switchServer: UISwitch = {
        let switchServ = UISwitch(frame:CGRect(x: 150, y: 300, width: 0, height: 0))
        switchServ.onTintColor  = Pallete.blueColor
        return switchServ
    }()
    
    let aboutGameWithServer: UIButton = {
        let button = UIButton()
//        button.layer.cornerRadius = 10
//        button.layer.borderColor = UIColor.lightGray.cgColor
//        button.layer.borderWidth = 0
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = UIColor.systemGray5
//        button.font = UIFont(name:"STHeitiTC-Light", size: 10.0) ?? nil!
        return button
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
        
        aboutGameWithServer.addTarget(self,
                                action: #selector(openInformationAboutGameWithServer),
                                for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(inputField)
        view.addSubview(switchServer)
        view.addSubview(switchLabel)
        view.addSubview(aboutGameWithServer)
        view.addSubview(buttonToBegin)
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
            $0.height.greaterThanOrEqualTo(50)
        }
        switchLabel.snp.makeConstraints {
            $0.top.equalTo(inputField.snp.bottom).offset(40)
            $0.left.equalTo(view.snp.left).offset(30)
        }
        aboutGameWithServer.snp.makeConstraints {
            $0.top.equalTo(inputField.snp.bottom).offset(37)
            $0.left.equalTo(switchLabel.snp.right).offset(3)
        }
        switchServer.snp.makeConstraints {
            $0.top.equalTo(inputField.snp.bottom).offset(40)
            $0.right.equalTo(view.snp.right).offset(-33)
        }
        buttonToBegin.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.left.equalTo(view.snp.left).offset(16)
            $0.right.equalTo(view.snp.right).offset(-16)
            $0.height.equalTo(50)
        }
    }
    
//    @objc func handleTap() {
//        inputField.resignFirstResponder()
//    }
    
    func showAlert(_ message: String?) {
    }
    
//    func hideAlert() {
//        inputField.format.titleAlwaysVisible = true
//        inputField.format.alertEnabled = false
//        inputField.format.alertLineActive = false
//        inputField.format.textColor = .black
//    }
    
    @objc func openInformationAboutGameWithServer() {
        let vc = InformationViewController()
        navigationController?.present(vc, animated: true)
    }
    
    @objc func handleShowNext() {
        let vc = GameViewController()
        guard let numbor = (inputField.text)?.description.toInt() else
        { return }
        
        if (1 < numbor), (numbor < 13) {
            vc.numberOfPlayers = numbor
            vc.isGameWithServer = switchServer.isOn
            navigationController?.pushViewController(vc, animated: true)
        } else {
            inputField.text = .none
            inputField.showAlert("От 2 до 12 игроков")
            inputField.format.alertPosition = .bottom
            inputField.format.textColor = .darkGray
        }
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


