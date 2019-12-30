//
//  CYHotAudiobookCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYHotAudiobookCell: UICollectionViewCell {
    
    // 图片
    private var picImgV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    // 标题
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    // 是否完结
    private var paidLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .white
        lab.backgroundColor = UIColor(red: 248/255.0, green: 210/255.0, blue: 74/255.0, alpha: 1.0)
        lab.textAlignment = .center
        lab.layer.masksToBounds = true
        lab.layer.cornerRadius = 3.0
        return lab
    }()
    
    // 副标题
    private var subLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .gray
        return lab
    }()
    
    // 播放数量
    private var numLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .gray
        return lab
    }()
    
    // 集数
    private var tracksLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .gray
        return lab
    }()
    
    // 播放数量图片
    private var numImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "playcount.png")
        return imgV
    }()
    
    // 集数图片
    private var trackImgV: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "track.png")
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        addSubview(self.picImgV)
        self.picImgV.image = UIImage(named: "pic1.jpeg")
        self.picImgV.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        addSubview(self.paidLab)
        self.paidLab.text = "完结"
        self.paidLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picImgV.snp.right).offset(10)
            make.top.equalTo(self.picImgV).offset(2)
            make.height.equalTo(16)
            make.width.equalTo(30)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.paidLab.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.picImgV)
            make.height.equalTo(20)
        }

        addSubview(self.subLab)
        self.subLab.text = "说服力的积分乐"
        self.subLab.snp.makeConstraints { (make) in
            make.right.height.equalTo(self.titleLab)
            make.left.equalTo(self.picImgV.snp.right).offset(10)
            make.top.equalTo(self.titleLab.snp.bottom).offset(10)
        }

        addSubview(self.numImgV)
        self.numImgV.snp.makeConstraints { (make) in
            make.left.equalTo(self.subLab)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(17)
        }

        addSubview(self.numLab)
        self.numLab.text = "> 1.6亿 1024集"
        self.numLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.numImgV.snp.right).offset(5)
            make.bottom.equalTo(self.numImgV)
            make.width.equalTo(60)
        }
        
        addSubview(self.trackImgV)
        self.trackImgV.snp.makeConstraints { (make) in
            make.left.equalTo(self.numLab.snp.right).offset(5)
            make.bottom.equalTo(self.numLab)
            make.width.height.equalTo(20)
        }
        
        addSubview(self.tracksLab)
        self.tracksLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.trackImgV.snp.right).offset(5)
            make.bottom.equalTo(self.trackImgV)
            make.width.equalTo(80)
        }
    }
    
    var recommendData: CYFMRecommendListModel? {
        didSet{
            guard let model = recommendData else { return }
            if model.pic != nil {
                self.picImgV.kf.setImage(with: URL(string: model.pic!))
            }
            if model.coverPath != nil {
                self.picImgV.kf.setImage(with: URL(string: model.coverPath!))
            }
            
            self.titleLab.text = model.title
            self.subLab.text = model.subtitle
            
            if model.isPaid {
                self.paidLab.isHidden = false
                self.paidLab.snp.updateConstraints { (make) in
                    make.width.equalTo(0)
                }
                self.titleLab.snp.updateConstraints { (make) in
                    make.left.equalTo(self.paidLab.snp.right)
                }
            }
            
            self.tracksLab.text = "\(model.tracksCount)集"
            var tagString: String?
            if model.playsCount > 100000000 {
                tagString = String(format: "%0.1f亿", Double(model.playsCount) / 100000000)
            }else if model.playsCount > 10000 {
                tagString = String(format: "%0.1f万", Double(model.playsCount) / 10000)
            }else {
                tagString = "\(model.playsCount)"
            }
            
            self.numLab.text = tagString
        }
    }
    
    var guessYouLikeModel: CYFMGuessYouLikeModel? {
        didSet {
            guard let model = guessYouLikeModel else { return }
            self.titleLab.text = model.title
            self.picImgV.kf.setImage(with: URL(string: model.coverMiddle!))
            self.subLab.text = model.recReason
            if model.isPaid {
                self.paidLab.isHidden = true
                self.paidLab.snp.updateConstraints { (make) in
                    make.width.equalTo(0)
                }
                self.titleLab.snp.updateConstraints { (make) in
                    make.left.equalTo(self.paidLab.snp.right)
                }
            }
            
            self.tracksLab.text = "\(model.tracks)集"
            var tagString: String?
            if model.playsCounts > 100000000 {
                tagString = String(format: "%0.1f亿", Double(model.playsCounts) / 100000000)
            }else if model.playsCounts > 10000 {
                tagString = String(format: "%0.1f万", Double(model.playsCounts) / 10000)
            }else {
                tagString = "\(model.playsCounts)"
            }
            
            self.numLab.text = tagString
            
        }
    }
    
}
