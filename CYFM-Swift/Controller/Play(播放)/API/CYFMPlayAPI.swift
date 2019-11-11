//
//  CYFMPlayAPI.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/11/7.
//  Copyright © 2019 CY. All rights reserved.
//

import Foundation
import Moya

let CYFMPlayProvider = MoyaProvider<CYFMPlayAPI>()

enum CYFMPlayAPI {
    case fmPlayData(albumId:Int,trackUid:Int, uid:Int)
}

extension CYFMPlayAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    var path: String {
        switch self {
        case .fmPlayData(let albumId, let trackUid, let uid):
            return "/mobile/track/v2/playpage/\(trackUid)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        var param = [
        "device":"iPhone",
        "operator":3,
        "scale":3,
        "appid":0,
        "ac":"WIFI",
        "network":"WIFI",
        "version":"6.5.3",
        "uid":124057809,
        "xt": Int32(Date().timeIntervalSince1970),
        "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        
        switch self {
        case .fmPlayData(albumId: let albumId, trackUid: let trackUid, uid: let uid):
            param["albumId"] = albumId
//            param["trackUid"] = trackUid
            param["trackUid"] = uid

        }
        
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

