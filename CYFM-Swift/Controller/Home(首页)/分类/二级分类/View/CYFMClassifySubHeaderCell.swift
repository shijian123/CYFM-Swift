//
//  CYFMClassifySubHeaderCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import FSPagerView

class CYFMClassifySubHeaderCell: UICollectionViewCell {
    private var focus: CYFMFocusModel?
    private var classifyCategoryContentsList: CYFMClassifyCategoryContentsList?
    
    let CYFMClassifySubCategoryCellID = "CYFMClassifySubCategoryCellID"
    
    private lazy var pageView: FSPagerView = {
        let pagerV = FSPagerView()
        pagerV.delegate = self
        pagerV.dataSource = self
        pagerV.automaticSlidingInterval = 3
        pagerV.isInfinite = true
        pagerV.interitemSpacing = 15
        pagerV.transformer = .init(type: .linear)
        pagerV.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "CELLID")
    }()
    
}

extension CYFMClassifySubHeaderCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        <#code#>
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        <#code#>
    }
    
    
}
