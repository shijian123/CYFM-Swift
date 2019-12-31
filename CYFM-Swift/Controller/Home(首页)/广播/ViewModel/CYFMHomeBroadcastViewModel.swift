//
//  CYFMHomeBroadcastViewModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CYFMHomeBroadcastViewModel: NSObject {
    
    // 更多电台分类是否展开状态
    var isUnfold: Bool = false
    /// 一下三个model是控制展开收起时电台数据显示
    let bottomModel = CYFMRadiosCategoriesModel(id: 10000, name: "arrows_bottom.png")
    let topModel = CYFMRadiosCategoriesModel(id: 10000, name:"arrows_top.png")
    let coverModel = CYFMRadiosCategoriesModel(id: 10000, name:" ")
    
    var titleArray = ["上海","排行榜"]
    // 数据模型
    var categories: [CYFMRadiosCategoriesModel]?
    var localRadios: [CYFMLocalRadiosModel]?
    var radioSquareResults: [CYFMRadioSquareResultsModel]?
    var topRadios: [CYFMTopRadiosModel]?

    typealias CYFMAddDataBlock = () -> Void
    var updataBlock: CYFMAddDataBlock?
    
}

extension CYFMHomeBroadcastViewModel {
    func refreshDataSource() {
        CYFMHomeBroadcastAPIProvider.request(.homeBroadcastList) { (result) in
            if case let .success(respond) = result {
                let data = try? respond.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMHomeBroadcastModel>.deserializeFrom(json: json.description){
                    self.categories = mappedObject.data?.categories
                    self.localRadios = mappedObject.data?.localRadios
                    self.radioSquareResults = mappedObject.data?.radioSquareResults
                    self.topRadios = mappedObject.data?.topRadios
                    self.categories?.insert(self.bottomModel, at: 7)
                    self.categories?.append(self.topModel)
                    
                    self.updataBlock?()
                }
            }
        }
    }
}

extension CYFMHomeBroadcastViewModel {
    // 每个分区显示item数量
      func numberOfItemsIn(section: NSInteger) -> NSInteger {
          if section == CYFMHomeBroadcastSectionTel {
              return 1
          }else if section == CYFMHomeBroadcastSectionMoreTel {
              if self.isUnfold {
                  return self.categories?.count ?? 0
              }else {
                  let num:Int = self.categories?.count ?? 0
                  return num / 2
              }
          }else if section == CYFMHomeBroadcastSectionLocal {
              return self.localRadios?.count ?? 0
          }else {
              return self.topRadios?.count ?? 0
          }
      }
      // 每个分区的内边距
      func insetForSectionAt(section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
      }
      
      // 最小 item 间距
      func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
          if section == CYFMHomeBroadcastSectionMoreTel {
            return 1.0
          }else {
              return 0.0
          }
      }
      
      // 最小行间距
      func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
          if section == CYFMHomeBroadcastSectionMoreTel {
            return 1.0
          }else {
              return 0.0
          }
      }
      
      // item 尺寸
      func sizeForItemAt(indexPath: IndexPath) -> CGSize {
          if indexPath.section == CYFMHomeBroadcastSectionTel {
              return CGSize.init(width:CYFMScreenWidth,height:90)
          }else if indexPath.section == CYFMHomeBroadcastSectionMoreTel {
              return CGSize.init(width:(CYFMScreenWidth-5)/4,height:45)
          }else {
              return CGSize.init(width:CYFMScreenWidth,height:120)
          }
      }
      
      // 分区头视图size
      func referenceSizeForHeaderInSection(section: Int) -> CGSize {
          if section == CYFMHomeBroadcastSectionTel || section == CYFMHomeBroadcastSectionMoreTel {
              return .zero
          }else {
              return CGSize.init(width: CYFMScreenWidth, height: 40)
          }
      }
      
      
      // 分区尾视图size
      func referenceSizeForFooterInSection(section: Int) -> CGSize {
          if section == CYFMHomeBroadcastSectionTel || section == CYFMHomeBroadcastSectionMoreTel {
              return .zero
          }else {
              return CGSize.init(width: CYFMScreenWidth, height: 10)
          }
      }
}


