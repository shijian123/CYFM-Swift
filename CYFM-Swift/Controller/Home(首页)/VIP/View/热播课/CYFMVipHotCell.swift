//
//  CYFMVipHotCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMVipHotCell: UICollectionViewCell {
    
    private var imageV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.imageV)
        self.imageV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageV.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    var categoryContentsModel: CYFMCategoryContents? {
        didSet {
            guard let model = categoryContentsModel else {
                return
            }
            self.imageV.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLab.text = model.title
        }
    }
    
}
