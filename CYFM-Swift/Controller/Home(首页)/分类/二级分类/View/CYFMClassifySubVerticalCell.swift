//
//  CYFMClassifySubVerticalCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubVerticalCell: UICollectionViewCell {
    
    private var picView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "pic1.jpeg")
        return imgV
    }()
    
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    private var paidLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .white
        lab.backgroundColor = UIColor(red: 248/255.0, green: 210/255.0, blue: 74/255.0, alpha: 1)
        lab.layer.masksToBounds = true
        lab.layer.cornerRadius = 3
        lab.textAlignment = .center
        return lab
    }()
    
    
    private var subLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .gray
        return lab
    }()
    
    private var numLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .gray
        return lab
    }()
    
    private var tracksLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .gray
        return lab
    }()
    
    private var numImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "playcount.png")
        return imgV
    }()
    
    private var tracksImgView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "track.png")
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.picView)
        self.picView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        addSubview(self.paidLab)
        self.paidLab.text = "完结"
        self.paidLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(self.picView).offset(2)
            make.height.equalTo(16)
            make.width.equalTo(30)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.paidLab.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.picView)
            make.height.equalTo(20)
        }
        
        addSubview(self.subLab)
        self.subLab.text = "HEZE"
        self.subLab.snp.makeConstraints { (make) in
            make.right.height.equalTo(self.titleLab)
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(self.titleLab.snp.bottom).offset(10)
        }
        
        addSubview(self.numImgView)
        self.numImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.subLab)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(17)
        }
        
        addSubview(self.numLab)
        self.numLab.text = "> 2.5亿 1248集"
        self.numLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.numImgView.snp.right).offset(5)
            make.bottom.equalTo(self.numImgView)
            make.width.equalTo(60)
        }
        
        addSubview(self.tracksImgView)
        self.tracksImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.numLab.snp.right).offset(5)
            make.bottom.equalTo(self.numLab)
            make.width.height.equalTo(20)
        }
        
        addSubview(self.tracksLab)
        self.tracksLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.tracksImgView.snp.right).offset(5)
            make.bottom.equalTo(self.tracksImgView)
            make.width.equalTo(80)
        }
    }
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {return}
            self.picView.kf.setImage(with: URL(string: model.coverMiddle!))
            
            if model.isPaid {
                self.paidLab.isHidden = true
                self.paidLab.snp.updateConstraints { (make) in
                    make.width.equalTo(0)
                }
                
                self.titleLab.snp.updateConstraints { (make) in
                    make.left.equalTo(self.paidLab.snp.right)
                }
            }
            
            self.titleLab.text = model.title
            self.subLab.text = model.intro
            self.tracksLab.text = "\(model.tracks)集"
            var tagStr: String?
            if model.playsCounts > 100000000 {
                tagStr = String(format: "%0.1f亿", Double(model.playsCounts)/100000000)
            }else if model.playsCounts > 10000 {
                tagStr = String(format: "0.1f万", Double(model.playsCounts)/10000)
            }else {
                tagStr = "\(model.playsCounts)"
            }
            self.numLab.text = tagStr
        }
    }
    
}
