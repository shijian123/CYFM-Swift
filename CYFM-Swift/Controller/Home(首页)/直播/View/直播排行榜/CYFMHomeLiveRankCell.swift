//
//  CYFMHomeLiveRankCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMHomeLiveRankCell: UICollectionViewCell {
    private var multidimensionalRankVosList: [CYFMMultidimensionalRankVosModel]?
    
    private let CYFMLiveRankCellID = "CYFMLiveRankCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (CYFMScreenWidth-30), height: self.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.contentSize = CGSize(width: (CYFMScreenWidth - 30), height: self.frame.size.height)
        collectionV.backgroundColor = .white
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.register(CYFMLiveRankCell.self, forCellWithReuseIdentifier: CYFMLiveRankCellID)
        return collectionV
    }()
    
    var myTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        starTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var multidimensionalRankVos: [CYFMMultidimensionalRankVosModel]? {
        didSet {
            guard let model = multidimensionalRankVos else {
                return
            }
            self.multidimensionalRankVosList = model
            self.collectionView.reloadData()
        }
    }
}

extension CYFMHomeLiveRankCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.multidimensionalRankVosList?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMLiveRankCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMLiveRankCellID, for: indexPath) as! CYFMLiveRankCell
        cell.backgroundColor = UIColor(red: 248/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1.0)
        cell.multidimensionalRankVos = self.multidimensionalRankVosList?[indexPath.row%(self.multidimensionalRankVosList?.count)!]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CYFMHelperTool.showNoFunctionWarning()
    }
    
    func starTimer() {
        let timer = Timer(timeInterval: 3.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        self.myTimer = timer
    }
    
    /// 在3秒后，自动跳转到下一页
    @objc func nextPage() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    /// 当collectionView开始拖动的时候,取消定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.myTimer?.invalidate()
        self.myTimer = nil
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        starTimer()
    }

}
