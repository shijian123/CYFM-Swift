//
//  CYFMHomeVipEnjoyCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

protocol CYFMHomeVipEnjoyCellDelegate: NSObjectProtocol {
    func homeVipEnjoyCellItemClick(model: CYFMCategoryContents)
}

class CYFMHomeVipEnjoyCell: UITableViewCell {
    weak var delegate: CYFMHomeVipEnjoyCellDelegate?
    private var categoryContents: [CYFMCategoryContents]?
    private let CYFMVipEnjoyCellID = "LBFMVipEnjoyCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: (CYFMScreenWidth - 50) / 3, height: self.frame.size.height)
        let colllectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colllectionV.delegate = self
        colllectionV.dataSource = self
        colllectionV.alwaysBounceVertical = true
        colllectionV.register(CYFMVipEnjoyCell.self, forCellWithReuseIdentifier: CYFMVipEnjoyCellID)
        return colllectionV
        
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
        didSet {
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


extension CYFMHomeVipEnjoyCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMVipEnjoyCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMVipEnjoyCellID, for: indexPath) as! CYFMVipEnjoyCell
        cell.categoryContentsModel = self.categoryContents?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.homeVipEnjoyCellItemClick(model: self.categoryContents![indexPath.row])
    }
    
}
