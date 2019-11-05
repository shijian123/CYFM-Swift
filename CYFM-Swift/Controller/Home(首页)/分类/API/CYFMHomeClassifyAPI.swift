//
//  CYFMHomeClassifyAPI.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/28.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import Moya

let CYFMHomeClassifProvider = MoyaProvider<CYFMHomeClassifyAPI>()

public enum CYFMHomeClassifyAPI {
    case classifyList
}

extension CYFMHomeClassifyAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .classifyList:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .classifyList:
            return "/mobile/discovery/v5/categories/1532410996452?channel=ios-b1&code=43_310000_3100&device=iPhone&gender=9&version=6.5.3%20HTTP/1.1"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    // 请求任务事件
    public var task: Task {
        switch self {
        case .classifyList:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
}


