//
//  CYFMFindModel.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON

/// 关注动态 Model
struct CYFMEventInfosModel: HandyJSON {
    var authorInfo:CYFMAttentionAuthorInfo?
    var contentInfo: CYFMFindAContentInfo?
    var eventTime: NSInteger = 0
    var id: NSInteger = 0
    var isFromRepost: Bool = false
    var isPraise: Bool = false
    var statInfo: CYFMFindAStatInfo?
    var timeline: NSInteger = 0
    var type: Int = 0
}

struct CYFMAttentionAuthorInfo: HandyJSON {
    var anchorGrade:Int = 0
    var avatarUrl: String?
    var isV: Bool = false
    var isVip: Bool = false
    var nickname: String?
    var uid: NSInteger = 0
    var userGrade: Int = 0
    var verifyType: Int = 0
}

struct CYFMFindAContentInfo: HandyJSON {
    var picInfos: [CYFMFindAPicInfos]?
    var text:String?
}

struct CYFMFindAPicInfos: HandyJSON {
    var id: NSInteger = 0
    var originUrl: String?
    var rectangleUrl:String?
    var squareUrl: String?
}

struct CYFMFindAStatInfo: HandyJSON {
    var commentCount: Int = 0
    var praiseCount: Int = 0
    var repostCount: Int = 0
}

/// 推荐动态 Model
struct CYFMFindRecommendModel: HandyJSON {
    var emptyTip: String?
    var endScore: Int = 0
    var hasMore: Bool = false
    var pullTip: String?
    var startScore: Int = 0
    var streamList: [CYFMFindRStreamList]?
    
}

struct CYFMFindRStreamList: HandyJSON {
    var avatar: String?
    var commentsCount: Int = 0
    var content: String?
    var id: Int = 0
    var issuedTs: Int = 0
    var liked: Bool = false
    var likesCount: Int = 0
    var nickname: String?
    var picUrls: [CYFMFindRPicUrls]?
    var recSrc: String?
    var recTrack: String?
    var score: Int = 0
    var subType: Bool = false
    var type: String?
    var uid : Int = 0
}

struct CYFMFindRPicUrls: HandyJSON {
    var originUrl: String?
    var thumbnailUrl: String?
}

/// 趣配音 Model
struct CYFMFMFindDubModel: HandyJSON {
    var data:[CYFMFindDubModel]?
}

struct CYFMFindDubModel: HandyJSON {
    var dubbingItem: CYFMFindDubdubbingItem?
    var feedItem: CYFMFindDubfeedItem?
}

struct CYFMFindDubdubbingItem: HandyJSON {
    var commentCount: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverPath: String?
    var coverSmall: String?
    var createAt: NSInteger = 0
    var duration: Int = 0
    var favorites: Int = 0
    var intro: String?
    var logoPic: String?
    var mediaType: String?
    var nickname: String?
    var playPathAacv164: String?
    var playPathAacv224: String?
    var relatedId: Int = 0
    var title: String?
    var topicId: Int = 0
    var topicTitle: String?
    var topicUrl: String?
    var trackId: Int = 0
    var uid: Int = 0
    var updatedAt: Int = 0
}

struct CYFMFindDubfeedItem: HandyJSON {
    var contentId: Int = 0
    var contentType: String?
    var recReason: String?
    var recSrc: String?
    var recTrack: String?
}
