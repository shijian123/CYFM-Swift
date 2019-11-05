//
//  CYFMHotAudiobookCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
/// 添加cell点击代理方法
protocol CYFMHotAudiobookCellDelegate: NSObjectProtocol {
    func hotAudiobookCellItemClick(model: CYFMRecommendListModel)
}

class CYFMHotAudiobookCell: UICollectionViewCell {
    weak var delegate: CYFMHotAudiobookCellDelegate?
    
    private var recommendList: [CYFMRecommendListModel]?
    
    private let CYHotAudiobookCellID = "CYHotAudiobookCell"
    private lazy var changeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("换一批", for: .normal)
        btn.setTitleColor(CYFMButtonColor, for: .normal)
        btn.backgroundColor = CYFMButtonBackgroundColor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5.0
        return btn
    }()
    
    private lazy var myCollectionV: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.alwaysBounceVertical = true
        collectionV.register(CYHotAudiobookCell.self, forCellWithReuseIdentifier: CYHotAudiobookCellID)
        return collectionV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        addSubview(self.myCollectionV)
        self.myCollectionV.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
    }
    
    var recommendListData: [CYFMRecommendListModel]? {
        didSet {
            guard let model = recommendListData else { return }
            self.recommendList = model
            self.myCollectionV.reloadData()
        }
    }
}

extension CYFMHotAudiobookCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYHotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYHotAudiobookCellID, for: indexPath) as! CYHotAudiobookCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.hotAudiobookCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 最小item间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CYFMScreenWidth-30, height: 120)
    }
    
    
}
