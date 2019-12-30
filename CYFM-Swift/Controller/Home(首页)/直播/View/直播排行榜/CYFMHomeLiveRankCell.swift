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
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.contentSize = CGSize(width: (CYFMScreenWidth - 30), height: self.frame.size.height)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.register(CYFMLiveRankCell.self, forCellWithReuseIdentifier: CYFMLiveRankCellID)
        return collectionV
    }()
    
    var time: 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var multidimensionalRankVos: [CYFMMultidimensionalRankVosModel]? {
        didSet {
            guard let model = multidimensionalRankVos else {
                self.multidimensionalRankVosList = model
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension CYFMHomeLiveRankCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
