//
//  CYFMClassifySubMenuController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/28.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import DNSPageView

class CYFMClassifySubMenuController: CYBaseController {

    private var categoryId: Int = 0
    private var isVipPush: Bool = false

    convenience init(categoryId: Int = 0, isVipPush: Bool = false) {
        self.init()
        self.categoryId = categoryId
        self.isVipPush = isVipPush
    }
    
    private var keywordList: [CYFMClassifySubMenuKeywords]?
    private lazy var nameArr = NSMutableArray()
    private lazy var keywordIDArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeaderCategoryData()
    }
    
    // 加载头部分类数据
    func loadHeaderCategoryData() {
        CYFMClassifySubMenuProvider.request(.headerCategoryList(categoryId: self.categoryId)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<CYFMClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description) {
                    self.keywordList = mappedObject as? [CYFMClassifySubMenuKeywords]
                    for keyword in self.keywordList! {
                        self.nameArr.add(keyword.keywordName!)
                    }
                    
                    if !self.isVipPush {
                        self.nameArr.insert("推荐", at: 0)
                    }
                    self.setupHeaderView()
                    
                }
            }
        }
    }
    
    
    func setupHeaderView(){
        let style = PageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = .black
        style.titleColor = .gray
        style.bottomLineColor = CYFMButtonColor
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = CYFMDownColor
        
        var vcArr = [UIViewController]()
        for keyword in self.keywordList! {
            let controller = CYFMClassifySubContentController(keywordId: keyword.keywordId, categoryId: keyword.categoryId)
            vcArr.append(controller)
        }
        
        if !self.isVipPush {
            let categoryId = self.keywordList?.last?.categoryId
            vcArr.insert(CYFMClassifySubRecommendController(categoryId: categoryId!), at: 0)
        }
        
        for vc in vcArr {
            addChild(vc)
        }
        
        let pageView = PageView(frame: CGRect(x: 0, y: CYFMNavBarHeight, width: CYFMScreenWidth, height: CYFMScreenHeight-CYFMNavBarHeight), style: style, titles: nameArr as! [String], childViewControllers: vcArr)
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
