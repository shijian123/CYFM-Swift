//
//  CYFMHomeLiveBannerCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/26.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import FSPagerView

class CYFMHomeLiveBannerCell: UICollectionViewCell {
    var liveBanner: [CYFMHomeLiveBanerList]?

    private let CYFMHomeLiveBannerCellID = "CYFMHomeLiveBannerCell"
    
    private lazy var pagerView: FSPagerView = {
        let pagerV = FSPagerView()
        pagerV.delegate = self
        pagerV.dataSource = self
        pagerV.automaticSlidingInterval = 3.0
        pagerV.isInfinite = !pagerV.isInfinite
        pagerV.register(FSPagerViewCell.self, forCellWithReuseIdentifier: CYFMHomeLiveBannerCellID)
        return pagerV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bannerList: [CYFMHomeLiveBanerList]? {
        didSet {
            guard let model = bannerList else {
                return
            }
            self.liveBanner = model
            self.pagerView.reloadData()
        }
    }
    
}

extension CYFMHomeLiveBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.liveBanner?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CYFMHomeLiveBannerCellID, at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.liveBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        CYFMHelperTool.showNoFunctionWarning()
    }
    
}
