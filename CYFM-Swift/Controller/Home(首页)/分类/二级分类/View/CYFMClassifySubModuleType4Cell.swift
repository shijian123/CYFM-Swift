//
//  CYFMClassifySubModuleType4Cell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubModuleType4Cell: UICollectionViewCell {
    private var picView: UIImageView = {
        let picV = UIImageView()
        picV.image = UIImage(named: "pic1.jpeg")
        return picV
    }()
    
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    private var subLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .gray
        lab.text = "啥地方看见好"
        return lab
    }()
    
    private var listenImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "listen")
        return imgView
    }()

    private var listenLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .gray
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
        addSubview(self.picView)
        self.picView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.picView)
            make.height.equalTo(20)
        }
        
        addSubview(self.subLab)
        self.subLab.snp.makeConstraints { (make) in
            make.right.height.equalTo(self.titleLab)
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(self.titleLab.snp.bottom).offset(10)
        }
        
        addSubview(self.listenImgView)
        self.listenImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.subLab)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(17)
        }
        
        addSubview(self.listenLab)
        self.listenLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.listenImgView.snp.right).offset(5)
            make.bottom.equalTo(self.listenImgView)
            make.width.equalTo(60)
        }
    }
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {
                return
            }
            self.picView.kf.setImage(with: URL(string: model.coverPathSmall!))
            self.titleLab.text = model.title
            self.subLab.text = model.subtitle
            self.listenLab.text = model.footnote
        }
    }
    
}

