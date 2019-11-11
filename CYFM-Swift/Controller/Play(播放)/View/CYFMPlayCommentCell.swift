//
//  CYFMPlayCommentCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/11/7.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMPlayCommentCell: UICollectionViewCell {
    private lazy var picView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "news.png")
        imgV.layer.masksToBounds = true
        imgV.layer.cornerRadius = 20
        return imgV
    }()
    
    private lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.text = "喜马拉雅"
        return lab
    }()
    
    private lazy var desLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.numberOfLines = 0
        lab.text = "安居客的撒发可近两年阿萨德开例会"
        return lab
    }()
    
    private lazy var dateLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .lightGray
        lab.text = "一天前"
        return lab
    }()
    
    private lazy var zanLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .lightGray
        lab.text = "20.5万"
        return lab
    }()
    
    private lazy var zanImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "点赞")
        return imgV
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
            make.centerX.equalTo(self.picView)
        }
        
        addSubview(self.desLab)
        self.desLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(self.picView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
        
        addSubview(self.dateLab)
        self.dateLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        addSubview(self.zanLab)
        self.zanLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        addSubview(self.zanImgView)
        self.zanImgView.snp.makeConstraints { (make) in
            make.right.equalTo(self.zanLab.snp.left).offset(-5)
            make.width.height.equalTo(20)
            make.centerY.equalTo(self.zanLab)
        }
    }
    
    var playCommentInfo: CYFMPlayCommentInfo? {
        didSet{
            guard let model = playCommentInfo else {
                return
            }
            self.picView.kf.setImage(with: URL(string: model.smallHeader!))
            self.nameLab.text = model.nickname
            self.desLab.text = model.content
            self.dateLab.text = CYFMHelperTool.updateTimeToCurrennTime(timeStamp: Double(model.createdAt))
            self.zanLab.text = "\(model.likes)"
            let textHeight: CGFloat = CYFMHelperTool.makeLabelHeight(for: model.content ?? "")
            self.desLab.snp.updateConstraints { (make) in
                make.height.equalTo(textHeight)
            }
        }
    }
    
}
