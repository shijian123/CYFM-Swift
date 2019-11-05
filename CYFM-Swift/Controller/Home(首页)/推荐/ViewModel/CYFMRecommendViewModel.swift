//
//  CYFMRecommendViewModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class CYFMRecommendViewModel: NSObject {
    // MARK - 数据模型
    var fmhomeRecommendModel:CYFMHomeRecommendModel?
    var homeRecommendList:[CYFMRecommendModel]?
    var recommendList : [CYFMRecommendListModel]?
    var focus:CYFMFocusModel?
    var squareList:[CYFMSquareModel]?
    var topBuzzList: [CYFMTopBuzzModel]?
    var guessYouLikeList: [CYFMGuessYouLikeModel]?
    var paidCategoryList: [CYFMPaidCategoryModel]?
    var playlist: CYFMPlaylistModel?
    var oneKeyListenList: [CYFMOneKeyListenModel]?
    var liveList: [CYFMLiveModel]?
    
    // Mark: -数据源更新
    typealias AddDataBlock = () -> Void // 声明
    var updateDataBlock: AddDataBlock? // 持有
    
}

extension CYFMRecommendViewModel {
    func refreshDataSource() {
        // 首页推荐接口请求
        CYFMRecommendProvider.request(.recommendList) { (result) in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<CYFMHomeRecommendModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.fmhomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    if let recommendList = JSONDeserializer<CYFMRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommendList = recommendList as? [CYFMRecommendListModel]
                    }
                    
                    if let focus = JSONDeserializer<CYFMFocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    
                    if let square = JSONDeserializer<CYFMSquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [CYFMSquareModel]
                    }
                    
                    if let topBuzz = JSONDeserializer<CYFMTopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [CYFMTopBuzzModel]
                    }
                    
                    if let oneKeyListen = JSONDeserializer<CYFMOneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [CYFMOneKeyListenModel]
                    }
                    
                    if let live = JSONDeserializer<CYFMLiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = live as? [CYFMLiveModel]
                    }
                    self.updateDataBlock?()
                }
            }
        }
    }
}

// collectionview数据
extension CYFMRecommendViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return self.homeRecommendList?.count ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight: Int = 90
        let itemNums = (self.homeRecommendList?[indexPath.section].list?.count)!/3
        let count = self.homeRecommendList?[indexPath.section].list?.count
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        
        if moduleType == "focus" {
            return CGSize(width: CYFMScreenWidth, height: 360)
        }else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live" {
            return CGSize(width: CYFMScreenWidth, height: CGFloat(HeaderAndFooterHeight+180*itemNums))
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore" {
            return CGSize(width: CYFMScreenWidth, height: CGFloat(HeaderAndFooterHeight+120*count!))
        }else if moduleType == "ad" {
            return CGSize(width: CYFMScreenWidth, height: 240)
        }else if moduleType == "oneKeyListen" {
            return CGSize(width: CYFMScreenWidth, height: 180)
        }else {
            return .zero
        }
    }
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        }else {
            return CGSize(width: CYFMScreenWidth, height: 40)
        }
    }
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize(width: CYFMScreenWidth, height: 10.0)
        }
    }
    
}

