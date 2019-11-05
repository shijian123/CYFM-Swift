 //
//  CYFMClassifySubCategoryCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubCategoryCell: UICollectionViewCell {
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = .center
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
        addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet{
            guard let model = classifyVerticalModel else {
                return
            }
            
            self.imgView.kf.setImage(with: URL(string: model.coverPath!))
            self.titleLab.text = model.title            
        }
    }
    
    
}
