//
//  CYFMHelperTool.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/11/9.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import SwiftMessages

class CYFMHelperTool: NSObject {
    
    // 计算文本高度
    class func makeLabelHeight(for contentStr: String) -> CGFloat {
        self.makeLabelHeight(for: contentStr, width: CYFMScreenWidth - 80)
    }
    
    // 计算文本高度
    class func makeLabelHeight(for contentStr: String, width: CGFloat) -> CGFloat {
        var height: CGFloat = 10
        if contentStr != "" {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 0
            label.text = contentStr
            
            height += label.sizeThatFits(CGSize(width: width, height: CGFloat.infinity)).height
        }
        return height
    }
    
    // 根据时间戳返回几分钟前，几小时前，几天前
    class func updateTimeToCurrennTime(timeStamp: Double) -> String {
        // 当前时间戳
        let currentTime = Date().timeIntervalSince1970
        // 时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta: TimeInterval = TimeInterval(timeStamp / 1000)
        // 时间差
        let reduceTime: TimeInterval = currentTime - timeSta
        if reduceTime < 60 {
            return "刚刚"
        }
        
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        
        // 不满足上述条件---或是未来日期---直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy年MM月"
        return dfmatter.string(from: date as Date )
        
    }
    
}


// 弹窗类型
extension CYFMHelperTool {
    /// 暂无此功能Base弹窗
    class func showNoFunctionWarning() {
        showNoFunctionWarning(text: "暂时没有点击功能")
    }
    
    /// 暂无此功能弹窗
    class func showNoFunctionWarning(text: String)  {
        let warningView = MessageView.viewFromNib(layout: .cardView)
        warningView.configureTheme(.warning)
        warningView.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].cy_random()!
        warningView.configureContent(title: "Warning", body: text, iconText: iconText)
        warningView.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warningView)
    }
}
