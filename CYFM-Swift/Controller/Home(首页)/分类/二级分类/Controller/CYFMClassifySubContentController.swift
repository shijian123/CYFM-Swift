//
//  CYFMClassifySubContentController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class CYFMClassifySubContentController: CYBaseController {

    private var keywordId: Int = 0
    private var categoryId: Int = 0
    
    convenience init(keywordId: Int = 0, categoryId: Int = 0) {
        self.init()
        self.keywordId = keywordId
        self.categoryId = categoryId
    }
    
    private var classifyVerticallist: [CYFMClassifyVerticalModel]?
    private let CYFMClassifySubVerticalCellID = "CYFMClassifySubVerticalCell"
    
    private lazy var myCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: CYFMScreenWidth - 15, height: 120)
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.register(CYFMClassifySubVerticalCell.self, forCellWithReuseIdentifier: CYFMClassifySubVerticalCellID)
        collectionV.cyHead = CYRefreshHeader{ [weak self] in
            self?.setupLoadData()
        }
        return  collectionV
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(self.myCollectionV)
        self.myCollectionV.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        self.myCollectionV.cyHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData() {
        CYFMClassifySubMenuProvider.request(.classifyOtherContentList(keywordId: self.keywordId, categoryId: self.categoryId)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<CYFMClassifyVerticalModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.classifyVerticallist = mappedObject as? [CYFMClassifyVerticalModel]
                    self.myCollectionV.cyHead.endRefreshing()
                    self.myCollectionV.reloadData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CYFMClassifySubContentController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classifyVerticallist?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubVerticalCellID, for: indexPath) as! CYFMClassifySubVerticalCell
        cell.classifyVerticalModel = self.classifyVerticallist?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = self.classifyVerticallist?[indexPath.row].albumId ?? 0
        let vc = CYFMPlayController(albumId: albumId)
        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true, completion: nil)
    }
    
}

