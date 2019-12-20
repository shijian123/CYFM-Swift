//
//  CYFMHomeRecommendLiveCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class CYFMHomeRecommendLiveCell: UICollectionViewCell {
    
    private var pageNum: Int = 0
    private var live: [CYFMLiveModel]?
    private let CYRecommendLiveCellID = "CYRecommendLiveCell"
    
    private lazy var changeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("换一换", for: .normal)
        btn.setTitleColor(CYFMButtonColor, for: .normal)
        btn.backgroundColor = CYFMButtonBackgroundColor
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(updateBtnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (CYFMScreenWidth - 55)/3.0, height: 180)
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.alwaysBounceVertical = true
        collectionV.register(CYRecommendLiveCell.self, forCellWithReuseIdentifier: CYRecommendLiveCellID)
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
        addSubview(self.myCollectionView)
        self.myCollectionView.snp.makeConstraints { (make) in
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
    
    var liveList: [CYFMLiveModel]? {
        didSet {
            guard let modelList = liveList else { return }
            self.live = modelList
            self.myCollectionView.reloadData()
        }
    }
    
    // 更换一批按钮刷新cell
    @objc func updateBtnClick(sender: UIButton) {
        pageNum += 1
        
        CYFMRecommendProvider.request(.changeLiveList(pageNum: pageNum)) { (result) in
            if case let .success(response) = result {
                let request = response.request
                print("网络请求：", request?.url as Any)
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMLiveModel>.deserializeModelArrayFrom(json: json["data"]["list"].description) {
                    self.live = mappedObject as? [CYFMLiveModel]
                    self.myCollectionView.reloadData()
                }
            }
        }
    }
    
}

extension CYFMHomeRecommendLiveCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.live?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYRecommendLiveCellID, for: indexPath) as! CYRecommendLiveCell
        cell.recommendLiveData = self.live?[indexPath.row]
        return cell
    }
    
    
}
