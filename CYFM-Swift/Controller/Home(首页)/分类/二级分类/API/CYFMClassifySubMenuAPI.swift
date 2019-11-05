//
//  CYFMClassifySubMenuAPI.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import Foundation
import Moya

let CYFMClassifySubMenuProvider = MoyaProvider<CYFMClassifySubMenuAPI>()

public enum CYFMClassifySubMenuAPI {
    // 顶部分类传参categoryId
    case headerCategoryList(categoryId: Int)
    // 推荐传参categoryId
    case classifyRecommendList(categoryId: Int)
    // 其他分类传参categoryId
    case classifyOtherContentList(keywordId: Int, categoryId: Int)
    
}

// 请求配置
extension CYFMClassifySubMenuAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    public var path: String {
        switch self {
        case .headerCategoryList:
            return "/discovery-category/keyword/all/1534468874767"
        case .classifyRecommendList:
            return "/discovery-category/v2/category/recommend/ts-1534469064622"
        case .classifyOtherContentList:
            return "/mobile/discovery/v2/category/metadata/albums/ts-1534469378814"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        var params = [String : Any]()
        switch self {
        case .headerCategoryList(categoryId: let categoryId):
            params = ["device":"iPhone","gender":9]
            params["categoryId"] = categoryId
        case .classifyRecommendList(categoryId: let categoryId):
            params = ["appid":0,
            "device":"iPhone",
            "gender":9,
            "inreview":false,
            "network":"WIFI",
            "operator":3,
            "scale":3,
            "uid":124057809,
            "version":"6.5.3",
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            params["categoryId"] = categoryId
        case .classifyOtherContentList(keywordId: let keywordId, categoryId: let categoryId):
            params = ["calcDimension":"hot",
            "device":"iPhone",
            "pageId":1,
            "pageSize":20,
            "status":0,
            "version":"6.5.3"]
            params["keywordId"] = keywordId
            params["categoryId"] = categoryId
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
