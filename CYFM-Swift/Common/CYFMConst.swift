//
//  CYFMConst.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/12.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

let CYFMScreenWidth = UIScreen.main.bounds.size.width
let CYFMScreenHeight = UIScreen.main.bounds.size.height

// 红色
let CYFMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let CYFMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

let CYFMButtonBackgroundColor = UIColor(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)

// iphone X
let isIphoneX = currentDeciveIsiPhoneX()
// CYFMNavBarHeight
let CYFMNavBarHeight : CGFloat = isIphoneX ? 88 : 64
// CYFMTabBarHeight
let CYFMTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49


func currentDeciveIsiPhoneX() -> Bool {
    
    let windowScene = UIApplication.shared.connectedScenes.first
    
    if let windowScene = windowScene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        let bottomNum = window.safeAreaInsets.bottom
        print("bottom：\(bottomNum)")
        if bottomNum == 0 {
            return false
        }
    }
    
    return true
}
