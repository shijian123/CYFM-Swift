//
//  CYFMVipEnjoyCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMVipEnjoyCell: UICollectionViewCell {
    // 图片
    private var imageV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    // 标题
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.numberOfLines = 0
        return lab
    }()
    
    // 喜点
    private var couponLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        return lab
    }()
    
    // 会员免费
    private var freeLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.backgroundColor = UIColor.init(red: 203/255.0, green: 148/255.0, blue: 95/255.0, alpha: 1)
        lab.text = "会员免费"
        lab.textColor = UIColor.white
        lab.layer.masksToBounds = true
        lab.layer.cornerRadius = 3
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
            make.bottom.equalToSuperview().offset(-110)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageV.snp.bottom).offset(10)
        }
        
        addSubview(self.couponLab)
        self.couponLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLab.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        addSubview(self.freeLab)
        self.freeLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(55)
            make.top.equalTo(self.couponLab.snp.bottom).offset(5)
            make.height.equalTo(18)
        }
    }
    
    var categoryContentsModel: CYFMCategoryContents? {
        didSet {
            guard let model = categoryContentsModel else {
                return
            }
            
            self.imageV.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLab.text = model.title
            let text = NSMutableAttributedString(string: "")
            text.append(NSAttributedString(string: "\(model.displayDiscountedPrice ?? "0")", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            self.couponLab.attributedText = text
        }
        
    }
    
    
}
