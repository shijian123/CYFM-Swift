//
//  CYFMHomeVipHotCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

/// 添加cell点击代理方法
protocol CYFMHomeVipHotCellDelegate: NSObjectProtocol {
    func homeVipHotCellItemClick(model: CYFMCategoryContents)
}

class CYFMHomeVipHotCell: UITableViewCell {

    weak var delegate: CYFMHomeVipHotCellDelegate?
    
    private var categoryContents: [CYFMCategoryContents]?
    private let CYFMVipHotCellID = "LBFMVipHotCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: (CYFMScreenWidth-50) / 3, height: self.frame.size.height)
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.backgroundColor = .white
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.alwaysBounceVertical = true
        collectionV.register(CYFMVipHotCell.self, forCellWithReuseIdentifier: CYFMVipHotCellID)
        return collectionV
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview()
        }
    }
    
    var categoryContentsModel: [CYFMCategoryContents]? {
        didSet{
            guard let model = categoryContentsModel else {
                return
            }
            self.categoryContents = model
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

extension CYFMHomeVipHotCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMVipHotCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMVipHotCellID, for: indexPath) as! CYFMVipHotCell
        cell.categoryContentsModel = self.categoryContents?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeVipHotCellItemClick(model: self.categoryContents![indexPath.row])
    }
    
}
