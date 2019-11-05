//
//  CYFMHomeController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import DNSPageView

class CYFMHomeController: CYBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageStyle()
    }
    
    func setupPageStyle() {
        // 创建DNSPageStyle，设置样式
        let style = PageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = .black
        style.titleColor = .gray
        style.bottomLineColor = CYFMButtonColor
        style.bottomLineHeight = 2.0
        style.bottomLineWidth = 40;
        
        let titles = ["推荐", "分类", "VIP", "直播", "广播"]
        let viewControllers: [UIViewController] = [CYFMHomeRecommendController(),CYFMHomeClassifyController(),CYFMHomeVIPController(),CYFMHomeLiveController(),CYFMHomeBroadcastController()]
        
        for vc in viewControllers {
            addChild(vc)
        }
        
        let pageView = PageView(frame: CGRect(x: 0, y: CYFMNavBarHeight, width: CYFMScreenWidth, height: CYFMScreenHeight - CYFMNavBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = .yellow
        view.addSubview(pageView)
        
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
