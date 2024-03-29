
import Foundation
import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    var numberArray = ["1","2","3","4","5","6","7","8","9"]
    
    let rolesLabel: UILabel  = {
        let label = UILabel()
        label.backgroundColor = Pallete.grayLabel
        label.textColor = .white
        label.font = UIFont(name:"STHeitiTC-Medium", size: 120.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.isHidden = true
        return label
    }()
    
    let nextHideButton: MainButton = {
        let button = MainButton()
        button.setTitle("Показать 👉", for: .normal)
        return button
    }()
    
    public var numberOfPlayers: Int = 0 {
        didSet {
            title = "Игроков: \(numberOfPlayers)"
        }
    }
    
    public var isGameWithServer: Bool = false
    
    private var arrayOfShuffledCards: [String] = []
    
    private var randomNumberSave: String = ""
    
    private var test: Int = 0
    
    public func some(test: Int) {
        self.test = test
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(closeHelloViewController))
        addSubviews()
        layoutConstraints()
        startNewGame()
        nextHideButtonApplyVibra()
    }
    
    func addSubviews() {
        view.addSubview(rolesLabel)
        view.addSubview(nextHideButton)
    }
    
    func layoutConstraints() {
        rolesLabel.snp.makeConstraints  {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(nextHideButton.snp.top).offset(-10)
            $0.left.equalTo(view.snp.left).offset(16)
            $0.right.equalTo(view.snp.right).offset(-16)
            
            nextHideButton.snp.makeConstraints {
                $0.height.equalTo(50)
                $0.left.equalTo(view.snp.left).offset(16)
                $0.right.equalTo(view.snp.right).offset(-16)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            }
        }
    }
    
    func startNewGame() {
        // Тут задаем рандомное число номера карточки
        let randomNumber = numberArray.randomElement()!
        var arrayOfCards: [String] = ["404"]
        //Если isGameWithServer true то peremennay = 0, иначе 1
        let peremennay = isGameWithServer ? 0 : 1
        for _ in 1...numberOfPlayers - peremennay {
            arrayOfCards.append(randomNumber)
        }
        arrayOfCards.shuffle()
        arrayOfShuffledCards = arrayOfCards
        randomNumberSave = randomNumber
        rolesLabel.text = arrayOfShuffledCards.popLast()
    }
    
    @objc func showHideCard(sender: UIButton) {
        sender.showAnimation()
        if self.rolesLabel.isHidden {
            self.rolesLabel.isHidden = false
            self.nextHideButton.setTitle("Скрыть 👇", for: .normal)
        } else {
            self.hideCard()
        }
    }
    
    func isAllCardShowed() -> Bool {
        if isGameWithServer {
            return (arrayOfShuffledCards.count == 1)
        } else {
            return arrayOfShuffledCards.isEmpty
        }
    }
    
    func hideCard() {
        // Если все карточки были показаны покажи "А все", а иначе присвой следующее значение лейблу и удали предыдущий, скрой лейбл и присвой кнопке ,Показать,
        if isAllCardShowed() {
            rolesLabel.font = UIFont(name:"STHeitiTC-Medium", size: 45.0)
            rolesLabel.text = "Роли распределены ⛔"
            nextHideButton.setTitle("Показать ответ", for: .normal)
            nextHideButton.backgroundColor = .systemRed
            
            nextHideButton.addAction(for: .touchUpInside) { [self] in
                showCorrectNumber()
            }
        } else {
            rolesLabel.text = arrayOfShuffledCards.removeFirst()
            rolesLabel.isHidden = true
            nextHideButton.setTitle("Показать 👉", for: .normal)
        }
    }
    
    @objc func showCorrectNumber() {
        rolesLabel.text = randomNumberSave.description
        if isGameWithServer == true {
            changeOptions()
            nextHideButton.setTitle("Робот среди нас?", for: .normal)
            showServer()
        } else {
            changeOptions()
            nextHideButton.setTitle("Спасибо за игру!", for: .normal)
            newGame()
        }
    }
    
    func showServer() {
        nextHideButton.addAction(for: .touchUpInside) { [self] in
            showGameWithServer()
        }
    }
    
    func changeOptions() {
        rolesLabel.backgroundColor = .systemRed
        rolesLabel.text = "Ответ: \(randomNumberSave.description)"
        rolesLabel.font = UIFont(name:"STHeitiTC-Medium", size: 50.0)
        nextHideButton.backgroundColor = .black
    }
    
    @objc func showGameWithServer() {
        rolesLabel.backgroundColor = .black
        nextHideButton.backgroundColor = .black
        nextHideButton.setTitle("Спасибо за игру!", for: .normal)
        newGame()
        textWasRobot()
    }
    
    func textWasRobot() {
        if arrayOfShuffledCards.last == "404" {
            rolesLabel.font = UIFont(name:"STHeitiTC-Medium", size: 50.0)
            rolesLabel.text = "Робот остался здесь! 🤖"
        } else {
            rolesLabel.font = UIFont(name:"STHeitiTC-Medium", size: 50.0)
            rolesLabel.text = "Робот среди вас 😱"
        }
    }
    
    func nextHideButtonApplyVibra() {
        nextHideButton.addAction(for: .touchUpInside) { [self] in
            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
            impactMed.impactOccurred()
            self.showHideCard(sender: nextHideButton)
        }
    }
    
    func newGame() {
        nextHideButton.addAction(for: .touchUpInside) { [self] in
            closeHelloViewController()
        }
    }
    
    @objc func closeHelloViewController() {
        dismiss(animated: true)
    }
}
