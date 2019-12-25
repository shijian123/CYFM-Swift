//
//  CYFMHomeVipViewModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CYFMHomeVipViewModel: NSObject {
    var homeVipModel: CYFMHomeVipModel?
    var focusImages: [CYFMFocusImagesData]?
    var categoryList: [CYFMCategoryList]?
    var categoryBtnList: [CYFMCategoryBtnModel]?
    
    typealias CYFMAddDataBlock = () -> Void
    var updateBlock: CYFMAddDataBlock?
    
    
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        switch section {
        case CYFMHomeVipSectionVip:
            return self.categoryList?[section].list?.count ?? 0
        default:
            return 1
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case CYFMHomeVipSectionBanner:
            return 150
        case CYFMHomeVipSectionGrid:
            return 80
        case CYFMHomeVipSectionHot:
            return 190
        case CYFMHomeVipSectionEnjoy:
            return 230
        default:
            return 120
        }
    }
    
    func heightForHeaderInSection(section:Int) ->CGFloat {
        if section == CYFMHomeVipSectionBanner || section == CYFMHomeVipSectionGrid {
            return 0.0
        }else {
            return 50
        }
    }
    
    func heightForFooterInSection(section:Int) ->CGFloat {
        if section == CYFMHomeVipSectionBanner {
            return 0.0
        }else {
            return 10
        }
    }
    
}

// MARK: - 请求数据
extension CYFMHomeVipViewModel {
    func refreshDataSource() {
        CYFMHomeVipAPIProvider.request(.homeVipList) { (result) in
            if case let .success(response) = result {
                print("网络请求：", response.request?.url! as Any)
                
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMHomeVipModel>.deserializeFrom(json: json.description) {
                    self.homeVipModel = mappedObject
                    self.focusImages = mappedObject.focusImages?.data
                    self.categoryList = mappedObject.categoryContents?.list
                }
                
                if let categoryBtn = JSONDeserializer<CYFMCategoryBtnModel>.deserializeModelArrayFrom(json: json["categoryContents"]["list"][0]["list"].description) {
                    self.categoryBtnList = categoryBtn as? [CYFMCategoryBtnModel]
                }
                
                self.updateBlock?()
            }
        }
    }
}

