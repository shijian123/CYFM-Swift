//
//  CYFMRecommendGuessLikeCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

/// 添加cell点击代理方法
protocol CYFMRecommendGuessLikeCellDelegate: NSObjectProtocol {
    func recommendGuessLikeCellItemClick(model: CYFMRecommendListModel)
}

class CYFMRecommendGuessLikeCell: UICollectionViewCell {
    weak var delegate : CYFMRecommendGuessLikeCellDelegate?
    
    private var recommendList: [CYFMRecommendListModel]?
    
    private let CYFMGuessYouLikeCellID = "CYFMGuessYouLikeCell"
    private lazy var changeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("换一批", for: .normal)
        btn.setTitleColor(CYFMButtonColor, for: .normal)
        btn.backgroundColor = CYFMButtonBackgroundColor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(updataBtnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let myCollectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionV.delegate = self
        myCollectionV.dataSource = self
        myCollectionV.backgroundColor = .white
        myCollectionV.alwaysBounceVertical = true
        myCollectionV.register(CYFMGuessYouLikeCell.self, forCellWithReuseIdentifier: CYFMGuessYouLikeCellID)
        return myCollectionV
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
            make.left.top.equalTo(10)
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
            self.myCollectionView.reloadData()
            
        }
    }
    
    // 更换一批按钮刷新cell
    @objc func updataBtnClick(sender: UIButton) {
        CYFMRecommendProvider.request(.changeGuessYouLikeList) { (result) in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [CYFMRecommendListModel]
                    self.myCollectionView.reloadData()
                }
            }
        }
    }
}

extension CYFMRecommendGuessLikeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMGuessYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMGuessYouLikeCellID, for: indexPath) as! CYFMGuessYouLikeCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGuessLikeCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    // 最小item间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (CYFMScreenWidth - 55)/3, height: 180)
    }
}

