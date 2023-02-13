
import Foundation
import UIKit

class InformationViewController: UIViewController {
    
    private let informationImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "info.circle")
        return view
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name:"STHeitiTC-Light", size: 20.0)
        return label
    }()
    
    private let robotImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        layoutConstraints()
        
        let urlString = "https://api.jsonbin.io/v3/b/63e0a185ebd26539d077339e"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            
            do {
                let modelInfo = try decoder.decode(WebResponse.self, from: data)
                
                let image = self.getImage(from: modelInfo.record.descriptions.first!.image)
                
                //                print("This is JSON result > \n\(modelInfo)")
                
                DispatchQueue.main.async {
                    self.informationLabel.text =  modelInfo.record.descriptions.first?.text
                    self.robotImageView.image = image
                }
            } catch {
                debugPrint("Error in JSON parsing!")
            }
        }
        dataTask.resume()
    }
    
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
        }
        
        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])
            
            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return image
    }
    
    func addSubviews() {
        view.addSubview(informationImageView)
        view.addSubview(informationLabel)
        view.addSubview(robotImageView)
    }
    
    func layoutConstraints() {
        informationImageView.snp.makeConstraints  {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.left.equalTo(view.snp.left).offset(30)
            $0.right.equalTo(view.snp.right).offset(-30)
            $0.height.equalTo(40)
        }
        
        robotImageView.snp.makeConstraints  {
            $0.top.equalTo(informationImageView.snp.bottom).offset(0)
            $0.left.equalTo(view.snp.left).offset(30)
            $0.right.equalTo(view.snp.right).offset(-15)
            $0.height.equalTo(150)
            $0.width.equalTo(250)
        }
        
        informationLabel.snp.makeConstraints  {
            $0.top.equalTo(robotImageView.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(30)
            $0.right.equalTo(view.snp.right).offset(-30)
            $0.height.equalTo(100)
            $0.width.equalTo(250)
        }
    }
}
