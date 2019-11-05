//
//  CYFMHomeClassifyViewModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/28.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

// 数据源更新
typealias CYFMAddDataBlock = () ->Void

class CYFMHomeClassifyViewModel: NSObject {
    var updateBlock: CYFMAddDataBlock?
    var classifyModel: [CYFMClassifyModel]?
}

// 请求数据
extension CYFMHomeClassifyViewModel {
    func refreshDataSource() {
        // 首页分类接口请求
        CYFMHomeClassifProvider.request(.classifyList) { (result) in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 字符串转换为对象实例
                if let mappedObject = JSONDeserializer<CYFMHomeClassifyModel>.deserializeFrom(json: json.description) {
                    self.classifyModel = mappedObject.list
                }
                self.updateBlock?()
            }
        }
    }
}

// collectionview数据
extension CYFMHomeClassifyViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return self.classifyModel?.count ?? 0
    }
    
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return self.classifyModel?[section].itemList?.count ?? 0
    }
    
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 2
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize(width: (CYFMScreenWidth - 10) / 4, height: 40)
        }else {
            return CGSize(width: (CYFMScreenWidth - 7.5) / 3, height: 40)
        }
    }
    
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return .zero
        }else {
            return CGSize(width: CYFMScreenWidth, height: 30)
        }
    }
    
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize(width: CYFMScreenWidth, height: 8.0)
    }
}


