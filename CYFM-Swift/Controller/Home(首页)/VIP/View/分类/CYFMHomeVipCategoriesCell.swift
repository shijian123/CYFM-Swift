//
//  CYFMHomeVipCategoriesCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

protocol CYFMHomeVipCategoriesCellDelegate: NSObjectProtocol {
    func homeVipCategoriesCellItemClick(id: String, url: String, title: String)
}

class CYFMHomeVipCategoriesCell: UITableViewCell {

    weak var delegate: CYFMHomeVipCategoriesCellDelegate?
    private var categoryBtnList: [CYFMCategoryBtnModel]?
    private let CYFMVipCategoryCellID = "CYFMVipCategoryCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: CYFMScreenWidth / 5, height: 80)
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.contentSize = CGSize(width: CYFMScreenWidth, height: 80)
        collectionV.backgroundColor = .white
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.register(CYFMVipCategoryCell.self, forCellWithReuseIdentifier: CYFMVipCategoryCellID)
        return collectionV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryBtnModel: [CYFMCategoryBtnModel]? {
        didSet {
            guard let model = categoryBtnModel else {
                return
            }
            self.categoryBtnList = model
            self.collectionView.reloadData()
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

extension CYFMHomeVipCategoriesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryBtnList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMVipCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMVipCategoryCellID, for: indexPath) as! CYFMVipCategoryCell
        cell.backgroundColor = .white
        cell.categoryBtnModel = self.categoryBtnList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = self.categoryBtnList?[indexPath.row]
        
        guard let string = model?.properties?.uri else {
            let id = "0"
            let url = model?.url ?? ""
            delegate?.homeVipCategoriesCellItemClick(id: id, url: url, title: model?.title ?? "")
            return
        }
        
        let id = getUrlCategoryId(url: string)
        let url = model?.url ?? ""
        delegate?.homeVipCategoriesCellItemClick(id: id, url: url, title: model?.title ?? "")
        
    }
    
    func getUrlCategoryId(url: String) -> String {
        
        if !url.contains("?") {
            return ""
        }
        
        var params = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        // 判断是否为多个参数
        if string.contains("&") {
            let urlComponents = string.split(separator: "&")
            for pairItem in urlComponents {
                let pairComponents = pairItem.split(separator: "=")
                let key: String = String(pairComponents[0])
                let value: String = String(pairComponents[1])
                params[key] = value
            }
        }else {
            let pairComponent = string.split(separator: "=")
            if pairComponent.count == 1 {
                return "nil"
            }
            
            let key: String = String(pairComponent[0])
            let value: String = String(pairComponent[1])
            params[key] = value
        }
        
        return params["category_id"] as! String
    }
    
}
