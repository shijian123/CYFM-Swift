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
        
        return pagerV
    }()
    
    private lazy var myLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    private lazy var gridView: UICollectionView = {
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: self.myLayout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.register(CYFMClassifySubCategoryCell.self, forCellWithReuseIdentifier: CYFMClassifySubCategoryCellID)
        return collectionV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.pageView)
        self.pageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.pageView.snp.bottom)
            make.height.equalTo(80)
        }
        self.pageView.itemSize = CGSize(width: CYFMScreenWidth - 60, height: 140)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var focusModel: CYFMFocusModel? {
        didSet {
            guard let model = focusModel else {
                return
            }
            self.focus = model
            self.pageView.reloadData()
        }
    }
    
    var classifyCategoryContentsListModel: CYFMClassifyCategoryContentsList? {
        didSet {
            guard let model = classifyCategoryContentsListModel else {
                return
            }
            
            self.classifyCategoryContentsList = model
            if (self.classifyCategoryContentsList?.list?.count)! == 10 {
                self.myLayout.scrollDirection = .vertical
            }else {
                self.myLayout.scrollDirection = .horizontal
            }
            
            self.gridView.reloadData()
        }
    }
    
}

extension CYFMClassifySubHeaderCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CELLID", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
}

extension CYFMClassifySubHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classifyCategoryContentsList?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMClassifySubCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubCategoryCellID, for: indexPath) as! CYFMClassifySubCategoryCell
        cell.classifyVerticalModel = self.classifyCategoryContentsList?.list?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
