//
//  CYBaseController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import SwiftMessages

class CYBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    
    /// 暂无此功能弹窗
    func showNoFunctionWarning() {
        let warningView = MessageView.viewFromNib(layout: .cardView)
        warningView.configureTheme(.warning)
        warningView.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].cy_random()!
        warningView.configureContent(title: "Warning", body: "暂时没有点击动能", iconText: iconText)
        warningView.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warningView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
