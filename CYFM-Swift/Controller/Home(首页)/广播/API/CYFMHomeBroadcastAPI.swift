//
//  CYFMHomeBroadcastAPI.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import Foundation
import Moya

let CYFMHomeBroadcastAPIProvider = MoyaProvider<CYFMHomeBroadcastAPI>()


enum CYFMHomeBroadcastAPI {
    case homeBroadcastList
    case categoryBroadcastList(path: String)
    case moreCategoryBroadcastList(categoryId: Int)
}

extension CYFMHomeBroadcastAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://live.ximalaya.com")!
    }
    
    var path: String {
        switch self {
        case .homeBroadcastList:
            return "/live-web/v5/homepage"
        case .categoryBroadcastList(let path):
            return path
        case .moreCategoryBroadcastList:
            return "/live-web/v2/radio/category"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .homeBroadcastList:
            return .requestPlain
        case .categoryBroadcastList:
            let params = [
            "device":"iPhone",
            "pageNum":1,
            "pageSize":30,
            "provinceCode":"310000"] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .moreCategoryBroadcastList(let categoryId):
            var params = [
                "device":"iPhone",
                "pageNum":1,
                "pageSize":30] as [String : Any]
            params["categoryId"] = categoryId
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
