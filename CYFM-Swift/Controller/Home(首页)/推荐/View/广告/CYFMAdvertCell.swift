//
//  CYFMAdvertCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMAdvertCell: UICollectionViewCell {
    
    private var imgView: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    private var subLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .gray
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        addSubview(self.imgView)
        self.imgView.image = UIImage(named: "fj.jpg")
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.clipsToBounds = true
        self.imgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        addSubview(self.titleLab)
        self.titleLab.text = "那些事"
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.imgView.snp.bottom)
            make.height.equalTo(30)
        }
        
        addSubview(self.subLab)
        self.subLab.text = "大家快回答会计法的闪电发货杀戮空间"
        self.subLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.titleLab.snp.bottom)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
    
    var adModel: CYFMRecommnedAdvertModel? {
        didSet {
            guard let model = adModel else { return }
            self.titleLab.text = model.name
            self.subLab.text = model.description
        }
    }
    
}

