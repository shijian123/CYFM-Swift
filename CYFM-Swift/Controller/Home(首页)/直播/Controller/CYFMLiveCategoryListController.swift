//
//  CYFMLiveCategoryListController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CYFMLiveCategoryListController: CYBaseController {

    private var liveList:[CYFMLivesModel]?
    
    private let CYFMRecommendLiveCellID = "CYFMRecommendLiveCell"
    private var channelId: Int = 0
    convenience init(channelId: Int = 0) {
        self.init()
        self.channelId = channelId
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 10.0
        layout.itemSize = CGSize(width: (CYFMScreenWidth - 40)/2, height: 230)
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.backgroundColor = .white
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        collectionV.register(CYFMRecommendLiveCell.self, forCellWithReuseIdentifier: CYFMRecommendLiveCellID)
        collectionV.cyHead = CYRefreshHeader{[weak self] in
            self?.setupLoadData()
        }
        return collectionV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        self.collectionView.cyHead.beginRefreshing()
    }
    
    func setupLoadData() {
        CYFMHomeLiveAPIProvider.request(.categoryLiveList(channelId: self.channelId)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMLivesModel>.deserializeModelArrayFrom(json: json["data"]["homePageVo"]["lives"].description) {
                    self.liveList = mappedObject as? [CYFMLivesModel]
                }
                self.collectionView.cyHead.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }

}

extension CYFMLiveCategoryListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.liveList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMRecommendLiveCellID, for: indexPath) as! CYFMRecommendLiveCell
        cell.liveModel = self.liveList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CYFMHelperTool.showNoFunctionWarning()
    }
    
}
