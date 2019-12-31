//
//  CYFMHomeRadiosCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMHomeRadiosCell: UICollectionViewCell {
    // 图片
    private var imgView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    // 标题
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    // 子标题
    private var subLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.gray
        return lab
    }()
    
    // 数量子标题
    private var numLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.gray
        return lab
    }()
    // 播放数量图片
    private var numView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "playcount.png")
        return imgV
    }()
    
    // 播放按钮
    private var playBtn : UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    func setUpLayout(){
        addSubview(self.imgView)
        self.imgView.image = UIImage(named: "pic1.jpeg")
        self.imgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.imgView)
            make.height.equalTo(20)
        }
        
        addSubview(self.subLab)
        self.subLab.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.titleLab)
            make.top.equalTo(self.titleLab.snp.bottom).offset(10)
        }
        
        addSubview(self.numView)
        self.numView.snp.makeConstraints { (make) in
            make.left.equalTo(self.subLab)
            make.bottom.equalToSuperview().offset(-17)
            make.width.height.equalTo(17)
        }
        
        addSubview(self.numLab)
        self.numLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.numView.snp.right).offset(5)
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    var localRadioModel: CYFMLocalRadiosModel? {
        didSet {
            guard let model = localRadioModel else { return }
            self.imgView.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLab.text = model.name
            let programName = model.programName ?? ""
            self.subLab.text = String(format: "正在直播:%@",programName)
            var numStr:String?
            if model.playCount > 100000000 {
                numStr = String(format: "%.1f亿", Double(model.playCount) / 100000000)
            } else if model.playCount > 10000 {
                numStr = String(format: "%.1f万", Double(model.playCount) / 10000)
            } else {
                numStr = "\(model.playCount)"
            }
            self.numLab.text = numStr
        }
    }
    
    var topRadioModel : CYFMTopRadiosModel? {
        didSet {
            guard let model = topRadioModel else { return }
            self.imgView.kf.setImage(with: URL(string: model.coverLarge!))
            self.titleLab.text = model.name
            let programName = model.programName ?? ""
            self.subLab.text = String(format: "正在直播:%@",programName)
            var numStr:String?
            if model.playCount > 100000000 {
                numStr = String(format: "%.1f亿", Double(model.playCount) / 100000000)
            } else if model.playCount > 10000 {
                numStr = String(format: "%.1f万", Double(model.playCount) / 10000)
            } else {
                numStr = "\(model.playCount)"
            }
            self.numLab.text = numStr
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
