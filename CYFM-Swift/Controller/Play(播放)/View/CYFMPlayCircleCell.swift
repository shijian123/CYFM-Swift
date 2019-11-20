//
//  CYFMPlayCircleCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/11/7.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMPlayCircleCell: UICollectionViewCell {
    private lazy var picView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.text = "喜马拉雅说的"
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var attentionLab: UILabel = {
        let lab = UILabel()
        lab.text = "成员 793   帖子 46"
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .gray
        return lab
    }()
    
    private var desLab: UILabel = {
        let lab = UILabel()
        lab.text = "数据的考试吧"
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.numberOfLines = 0
        return lab
    }()
    
    private lazy var bgImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "cell_bg_commentline_355x86_")
        return imgV
    }()
    
    private lazy var joinBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("加入", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = CYFMButtonColor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 15
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
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
        self.picView.image = UIImage(named: "news.png")
        self.picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        addSubview(self.nameLab)
        self.nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(20)
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
     
        self.bgImgView.addSubview(self.desLab)
        self.desLab.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-15)
        }
        
        addSubview(self.joinBtn)
        self.joinBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.centerY.equalTo(self.picView)
        }
    }
    
    var communityInfo: CYFMPlayCommunityInfo? {
        didSet {
            guard let model = communityInfo else {
                return
            }
            self.picView.kf.setImage(with: URL(string: model.logoSmall!))
            self.nameLab.text = model.name
            self.desLab.text = model.introduce
        }
    }
    
}
