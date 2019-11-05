//
//  CYRefresh.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var cyHead: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }
    
    var cyFoot: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

class CYRefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .idle)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .pulling)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!,
        UIImage(named: "pullToRefresh_1_80x60_")!,
        UIImage(named: "pullToRefresh_2_80x60_")!,
        UIImage(named: "pullToRefresh_3_80x60_")!,
        UIImage(named: "pullToRefresh_4_80x60_")!,
        UIImage(named: "pullToRefresh_5_80x60_")!,
        UIImage(named: "pullToRefresh_6_80x60_")!,
        UIImage(named: "pullToRefresh_7_80x60_")!,
        UIImage(named: "pullToRefresh_8_80x60_")!,
        UIImage(named: "pullToRefresh_9_80x60_")!,], for: .refreshing)
        
        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
    }
}

class CYRefreshAutoHeader: MJRefreshHeader {}

class CYRefreshFooter: MJRefreshBackNormalFooter {}

class CYRefreshAutoFooter: MJRefreshAutoFooter {}

class CYRefreshDiscoverFooter: MJRefreshBackGifFooter {
    
    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.clear
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .idle)
        stateLabel.isHidden = true
        refreshingBlock = { self.endRefreshing() }
    }
}

class CYRefreshTipKissFooter: MJRefreshBackFooter {
    
    lazy var tipLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.textColor = UIColor.lightGray
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.numberOfLines = 0
        return lab
    }()
    
    lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "pullToRefresh_0_80x60_")
        return imgV
    }()
    
    override func prepare() {
        super.prepare()
        backgroundColor = .clear
        mj_h = 240
        addSubview(tipLabel)
        addSubview(imageView)
    }
    
    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 40, width: bounds.width, height: 60)
        imageView.frame = CGRect(x: (bounds.width - 80 ) / 2, y: 110, width: 80, height: 80)
    }
    
    convenience init(with tip: String) {
        self.init()
        refreshingBlock = { self.endRefreshing() }
        tipLabel.text = tip
    }
}
