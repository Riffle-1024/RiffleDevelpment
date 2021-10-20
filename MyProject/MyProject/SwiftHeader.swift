//
//  SwiftHeader.swift
//  MyProject
//
//  Created by liuyalu on 2021/9/28.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.self.width

let ScreenHeight = UIScreen.main.bounds.self.height

let firstColor = UIColor.init(red: 223/255.0, green: 83/255.0, blue: 64/255.0, alpha: 0.5)

let secondColor = UIColor.init(red: 236/255.0, green: 90/255.0, blue: 66/255.0, alpha: 0.5)

let mWATERWAVE_DEFAULT_SPEED = 0.1

let mWATERWAVE_DEFAULT_PEAK = 6.0

let mWATERWAVE_DEFAULT_PERIOD = 2.0

func colorWithAlpha(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor
{
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

func hexColor(str:String,alpha:CGFloat) -> UIColor
{
    return UIColor.init(hexString: str, alpha: alpha)
}
