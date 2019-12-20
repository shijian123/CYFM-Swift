//
//  CYFMHomeVipAPIProvider.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import Foundation
import Moya


let CYFMHomeVipAPIProvider = MoyaProvider<CYFMHomeVipAPI>()

enum CYFMHomeVipAPI {
    case homeVipList
}

// 请求配置
extension CYFMHomeVipAPI: TargetType {

    // 服务器地址
    var baseURL: URL {
        switch self {
        case .homeVipList:
            return URL(string: "http://mobile.ximalaya.com")!

        }
    }

    // 各个请求的具体路径
    var path: String {
        switch self {
        case .homeVipList:
            return "/product/v4/category/recommends/ts-1532592638951"
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
        case .homeVipList:
            let params = [
                "appid":0,
                "categoryId":33,
                "contentType":"album",
                "inreview":false,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":0,
                "device":"iPhone",
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
                ] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return nil
    }


}

