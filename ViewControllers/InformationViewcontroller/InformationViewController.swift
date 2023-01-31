//
//  InformationViewController.swift
//  Im not robot
//
//  Created by Котик on 31.01.2023.
//

import Foundation
import UIKit

class InformationViewController: UIViewController {
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 15
//        label.layer.borderColor = UIColor.lightGray.cgColor
//        label.layer.borderWidth = 1
        label.text = "Карточка '404' может не достаться игрокам"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name:"STHeitiTC-Light", size: 20.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        layoutConstraints()
    }
    
    func addSubviews() {
        view.addSubview(informationLabel)
    }
    
    func layoutConstraints() {
        informationLabel.snp.makeConstraints  {
            $0.height.equalTo(150)
            $0.width.equalTo(300)
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            }
        }
}
