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
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var attentionLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .gray
        return lab
    }()
    
    private var desLab: UILabel = {
        let lab = UILabel()
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
    }
    
}
