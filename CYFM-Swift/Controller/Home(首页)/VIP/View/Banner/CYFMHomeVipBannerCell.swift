//
//  CYFMHomeVipBannerCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import FSPagerView

protocol CYFMHomeVipBannerCellDelegate: NSObjectProtocol {
    func homeVipBannerCellClick(url: String)
}

class CYFMHomeVipBannerCell: UITableViewCell {

    weak var delegate: CYFMHomeVipBannerCellDelegate?
    var vipBanner: [CYFMFocusImagesData]?
    let CYFMHomeVipBannerCellID = "CYFMHomeVipBannerCell"
    
    private lazy var pagerView: FSPagerView = {
        let pagerV = FSPagerView()
        pagerV.delegate = self
        pagerV.dataSource = self
        pagerV.automaticSlidingInterval = 3
        pagerV.isInfinite = true
        pagerV.interitemSpacing = 15
        pagerV.transformer = FSPagerViewTransformer(type: .linear)
        pagerV.register(FSPagerViewCell.self, forCellWithReuseIdentifier: CYFMHomeVipBannerCellID)
        return pagerV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        self.pagerView.itemSize = CGSize(width: CYFMScreenWidth-60, height: 140)
    }
    
    var vipBannerList: [CYFMFocusImagesData]? {
        didSet {
            guard let model = vipBannerList else {
                return
            }
            self.vipBanner = model
            self.pagerView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CYFMHomeVipBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.vipBanner?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CYFMHomeVipBannerCellID, at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.vipBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url: String = self.vipBanner?[index].link ?? ""
        delegate?.homeVipBannerCellClick(url: url)
    }
    
}
