//
//  CYFMHomeBroadcastModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import Foundation
import HandyJSON

// 首页广播数据模型
struct CYFMHomeBroadcastModel : HandyJSON {
    var data:CYFMRadiosModel?
    var ret: Int = 0
}

struct CYFMRadiosModel: HandyJSON {
    var categories: [CYFMRadiosCategoriesModel]?
    var localRadios: [CYFMLocalRadiosModel]?
    var location: String?
    var radioSquareResults: [CYFMRadioSquareResultsModel]?
    var topRadios: [CYFMTopRadiosModel]?
}

struct CYFMRadiosCategoriesModel: HandyJSON{
    var id: Int = 0
    var name: String?
}

struct CYFMLocalRadiosModel :HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [CYFMRadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}

struct CYFMRadiosPlayUrlModel :HandyJSON {
    var aac24: String?
    var aac64: String?
    var ts24: String?
    var ts64: String?
}

struct CYFMRadioSquareResultsModel: HandyJSON {
    var icon: String?
    var id: Int = 0
    var title: String?
    var uri: String?
}

struct CYFMTopRadiosModel: HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [CYFMRadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}


