//
//  CYFMPlayAnchorCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/11/7.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMPlayAnchorCell: UICollectionViewCell {
    private lazy var picView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "news.png")
        imgV.layer.masksToBounds = true
        imgV.layer.cornerRadius = 20
        return imgV
    }()
    
    private lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.text = "喜马拉雅"
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var attentionLab: UILabel = {
        let lab = UILabel()
        lab.text = "你已经被5.4w人关注"
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    private lazy var desLab: UILabel = {
        let lab = UILabel()
        lab.text = "水卡很单薄"
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.numberOfLines = 0
        return lab
    }()
    
    private lazy var bgImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "search_hint_histrack_bg_297x33_")
        return imgV
    }()
    
    private lazy var sponsorBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "sponsorBtn_41x30_"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.picView)
        self.picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        addSubview(self.nameLab)
        self.nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(self.picView)
        }
        
        addSubview(self.attentionLab)
        self.attentionLab.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(self.nameLab)
            make.top.equalTo(self.nameLab.snp.bottom).offset(5)
        }
    
        addSubview(self.bgImgView)
        self.bgImgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.picView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        addSubview(self.desLab)
        self.desLab.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        addSubview(self.sponsorBtn)
        self.sponsorBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(41)
            make.height.equalTo(30)
            make.centerY.equalTo(self.picView)
        }
    }
    
    var userInfo: CYFMPlayUserInfo? {
        didSet {
            guard let model = userInfo else {
                return
            }
            
            self.picView.kf.setImage(with:URL(string: model.smallLogo!))
            self.nameLab.text = model.nickname
            var tagStr: String = ""
            if model.followers > 100000000 {
                tagStr = String(format: "%.1亿", Double(model.followers) / 100000000)
            }else if model.followers > 10000 {
                tagStr = String(format: "%.1f万", Double(model.followers) / 10000)
            }else {
                tagStr = "\(model.followers)"
            }
            
            self.attentionLab.text = "已被\(tagStr)人关注"
        }
    }
    
}
