//
//  MainColor.swift
//  Im not robot
//
//  Created by Котик on 08.09.2022.
//

import Foundation
import UIKit

class Pallete {
    static var blueColor: UIColor = UIColor.hex("#296ed0")
    static var fillSecondary: UIColor = UIColor.hex("#787880")
    static var blueAnother: UIColor = UIColor.hex("#378eff")
    static var lightGray: UIColor = UIColor.hex("#D3D3D3")
    static var lightRed: UIColor = UIColor.hex("#cf7986")
}

extension UIColor {
    static func hex(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
