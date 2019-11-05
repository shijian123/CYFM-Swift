//
//  CYFMClassifySubRecommendViewModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CYFMClassifySubRecommendViewModel: NSObject {
    // 外部传值请求接口如此那
    var categoryId = 0
    
    convenience init(categoryId: Int = 0) {
        self.init()
        self.categoryId = categoryId
    }

    var classifyCategoryContentsList: [CYFMClassifyCategoryContentsList]?
    var classifyModuleType14List: [CYFMClassifyModuleType14Model]?
    var classifyModuleType19List: [CYFMClassifyModuleType19Model]?
    var classifyModuleType20List: [CYFMClassifyModuleType20Model]?
    var classifyVerticalList: [CYFMClassifyVerticalModel]?
    var focus: CYFMFocusModel?
    
    typealias CYFMUpdataBlock = () ->Void
    var updataBlock: CYFMUpdataBlock?
}

extension CYFMClassifySubRecommendViewModel {
    func refreshDataSource() {
        // 分类二级界面推荐接口请求
        CYFMClassifySubMenuProvider.request(.classifyRecommendList(categoryId: self.categoryId)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<CYFMClassifyCategoryContentsList>.deserializeModelArrayFrom(json: json["categoryContents"]["list"].description) {
                    self.classifyCategoryContentsList = mappedObject as? [CYFMClassifyCategoryContentsList]
                }
                
                if let focusModel = JSONDeserializer<CYFMFocusModel>.deserializeFrom(json: json["focusImages"].description) {
                    self.focus = focusModel
                }
                
                self.updataBlock?()
            }
        }
    }
}

extension CYFMClassifySubRecommendViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return self.classifyCategoryContentsList?.count ?? 0
    }
    
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if moduleType == 14 || moduleType == 19 || moduleType == 20 {
            return 1
        }else {
            return self.classifyCategoryContentsList?[section].list?.count ?? 0
        }
    }
    
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        let cardClass = self.classifyCategoryContentsList?[section].cardClass
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if cardClass == "horizontal" || moduleType == 16 {
            return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        }else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        let cardClass = self.classifyCategoryContentsList?[section].cardClass
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        
        if cardClass == "horizontal" || moduleType == 16 {
            return 5
        }else {
            return 0
        }
    }

    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        let cardClass = self.classifyCategoryContentsList?[section].cardClass
        let moduleType = self.classifyCategoryContentsList?[section].moduleType

        if cardClass == "horizontal" || moduleType == 16 {
            return 5
        }else {
            return 0
        }
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let cardClass = self.classifyCategoryContentsList?[indexPath.section].cardClass
        let moduleType = self.classifyCategoryContentsList?[indexPath.section].moduleType
        
        if moduleType == 14 {
            let num: Int = (self.classifyCategoryContentsList?[indexPath.section].list?.count)!
            if num >= 10 {// 这里是判断推荐页面滚动banner下面的分类按钮的高度
                return CGSize(width: CYFMScreenWidth, height: 320)
            }else {
                return CGSize(width: CYFMScreenWidth, height: 230)
            }
        }else if moduleType == 3 || moduleType == 5 || moduleType == 18 {
            if cardClass == "horizontal" {
                return CGSize(width: (CYFMScreenWidth - 50)/3, height: 180)
            }else {
                return CGSize(width: CYFMScreenWidth, height: 120)
            }
        }else if moduleType == 20 {
            return CGSize(width: CYFMScreenWidth, height: 300)
        }else if moduleType == 19 {
            return CGSize(width: CYFMScreenWidth, height: 200)
        }else if moduleType == 17 {
            return CGSize(width: CYFMScreenWidth, height: 180)
        }else if moduleType == 16 {
            return CGSize(width: (CYFMScreenWidth - 50)/3, height: 180)
        }else if moduleType == 4 {
            return CGSize(width: CYFMScreenWidth, height: 120)
        }else{
            return .zero
        }
    }
    
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if moduleType == 14 || moduleType == 17 || moduleType == 20 {
            return .zero
        }
        
        return CGSize(width: CYFMScreenWidth, height: 40)
    }
    
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize(width: CYFMScreenWidth, height: 10)
    }
    
    
}
