//
//  CYFMHomeLiveViewModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CYFMHomeLiveViewModel: NSObject {
    // 外部传递值
    var categoryType = 0
    convenience init(categoryType: Int = 0) {
        self.init()
        self.categoryType = categoryType
    }
    
    var homeLiveData: CYFMHomeLiveDataModel?
    var lives:[CYFMLivesModel]?
    var categoryVoList:[CYFMCategoryVoList]?
    var homeLiveBanerList:[CYFMHomeLiveBanerList]?
    var multidimensionalRankVos: [CYFMMultidimensionalRankVosModel]?
    
    typealias CYFMAddDataBlock = () -> Void
    var updataBlock: CYFMAddDataBlock?
    
}

// - 请求数据
extension CYFMHomeLiveViewModel {
    func refreshDataSource() {
        loadLiveData()
    }
    
    func loadLiveData() {
        
        let grpup = DispatchGroup()
        grpup.enter()
        // 首页直播接口请求
        CYFMHomeLiveAPIProvider.request(.liveList) { (result) in
            if case let .success(response) = result {
                print("网络请求：" + (response.request?.url?.absoluteString ?? ""))
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMHomeLiveModel>.deserializeFrom(json: json.description) {
                    self.lives = mappedObject.data?.lives
                    self.categoryVoList = mappedObject.data?.categoryVoList
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        // 首页直播滚动图接口请求
        CYFMHomeLiveAPIProvider.request(.liveBannerList) { (result) in
            if case let .success(response) = result {
                print("网络请求：" + (response.request?.url?.absoluteString ?? ""))
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMHomeLiveBanerModel>.deserializeFrom(json: json.description) {
                    self.homeLiveBanerList = mappedObject.data
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        // 首页直播排行榜接口请求
        CYFMHomeLiveAPIProvider.request(.liveRankList) { (result) in
            if case let .success(response) = result {
                print("网络请求：" + (response.request?.url?.absoluteString ?? ""))
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappObject = JSONDeserializer<CYFMHomeLiveRankModel>.deserializeFrom(json: json.description) {
                    self.multidimensionalRankVos = mappObject.data?.multidimensionalRankVos
                    grpup.leave()
                }
            }
        }
        
        grpup.notify(queue: DispatchQueue.main) {
            self.updataBlock?()
        }
        
    }
}

// - 点击分类刷新主页数据请求数据
extension CYFMHomeLiveViewModel {
    func refreshCategoryLiveData() {
        loadCategoryLiveData()
    }
    func loadCategoryLiveData() {
        CYFMHomeLiveAPIProvider.request(.categoryTypeList(categoryType: self.categoryType)) { (result) in
            if case let .success(response) = result {
                
                print("网络请求" + (response.request?.url?.absoluteString ?? ""))
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMLivesModel>.deserializeModelArrayFrom(json: json["data"]["lives"].description) {
                    self.lives = mappedObject as? [CYFMLivesModel]
                }
                self.updataBlock?()
            }
        }
    }
}

// - collectionview数据
extension CYFMHomeLiveViewModel {
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == CYFMHomeLiveSectionLive {
            return self.lives?.count ?? 0
        }else {
            return 1
        }
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 5
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 10
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case CYFMHomeLiveSectionGrid:
            return CGSize(width:CYFMScreenWidth - 30,height:90)
        case CYFMHomeLiveSectionBanner:
            return CGSize(width:CYFMScreenWidth - 30,height:110)
        case CYFMHomeLiveSectionRank:
            return CGSize(width:CYFMScreenWidth - 30,height:70)
        default:
            return CGSize(width:(CYFMScreenWidth - 40)/2,height:230)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == CYFMHomeLiveSectionLive{
            return CGSize.init(width: CYFMScreenWidth, height: 40)
        }else {
            return .zero
        }
    }
}



