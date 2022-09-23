
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
//        label.layer.borderWidth = 5.0
        label.isHidden = true
        return label
    }()
    
    let nextHideButton: MyButton = {
        let button = MyButton()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        layoutConstraints()
        startNewGame()
        nextHideButton.addTarget(self,
                                 action: #selector(showHideCard),
                                 for: .touchUpInside)
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
//                    $0.top.equalTo(rolesLabel.snp.bottom).offset(40)
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
    
    @objc func showHideCard() {
        if rolesLabel.isHidden {
            rolesLabel.isHidden = false
            nextHideButton.setTitle("Скрыть 👇", for: .normal)
        } else {
            hideCard()
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
            rolesLabel.text = "А всё ⛔"
            nextHideButton.setTitle("Показать ответ", for: .normal)
            nextHideButton.backgroundColor = .systemRed
            showAnswer()
        } else {
            rolesLabel.text = arrayOfShuffledCards.removeFirst()
            rolesLabel.isHidden = true
            nextHideButton.setTitle("Показать 👉", for: .normal)
        }
    }
    
    func showAnswer() {
        nextHideButton.addTarget(self,
                                 action: #selector(showCorrectNumber),
                                 for: .touchUpInside)
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
        nextHideButton.addTarget(self,
                                 action: #selector(showGameWithServer),
                                 for: .touchUpInside)
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
//        if arrayOfShuffledCards.contains("404") {
        if arrayOfShuffledCards.last == "404" {
            rolesLabel.font = UIFont(name:"STHeitiTC-Medium", size: 50.0)
            rolesLabel.text = "Робот остался здесь! 🤖"
        } else {
            rolesLabel.font = UIFont(name:"STHeitiTC-Medium", size: 50.0)
            rolesLabel.text = "Робот среди вас 😱"
        }
    }
    
    func newGame() {
        nextHideButton.addTarget(self,
                                 action: #selector(openHelloViewController),
                                 for: .touchUpInside)
        print(arrayOfShuffledCards)
    }
    
    @objc func openHelloViewController() {
        navigationController?.popViewController(animated: true)
    }
}
