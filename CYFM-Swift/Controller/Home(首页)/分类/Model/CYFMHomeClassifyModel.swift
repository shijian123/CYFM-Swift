//
//  CYFMHomeClassifyModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/28.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON

struct CYFMHomeClassifyModel: HandyJSON {
    var list: [CYFMClassifyModel]?
    var msg: String?
    var code: String?
    var ret: Int = 0
}


struct CYFMClassifyModel: HandyJSON {
    var groupName: String?
    var displayStyleType: Int = 0
    var itemList: [CYFMItemList]?
}

struct CYFMItemList: HandyJSON {
    var itemType: Int = 0
    var coverPath: String?
    var isDisplayCornerMark: Bool = false
    var itemDetail: CYFMItemDetail?
}

struct CYFMItemDetail: HandyJSON {
    var categoryId: Int = 0
    var name: String?
    var title: String?
    var categoryType: Int = 0
    var moduleType: Int = 0
    var filterSupported: Bool = false
    var keywordId: Int = 0
    var keywordName: String?
}
