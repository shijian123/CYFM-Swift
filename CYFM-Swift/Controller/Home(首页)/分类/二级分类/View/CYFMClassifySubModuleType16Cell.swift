//
//  CYFMClassifySubModuleType16Cell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubModuleType16Cell: UICollectionViewCell {
    private var imgView: UIImageView = {
        let imgV = UIImageView()
        imgV.layer.cornerRadius = 8
        imgV.layer.masksToBounds = true
        return imgV
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
        lab.numberOfLines = 0
        return lab
    }()
    
    private var categoryLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = .white
        lab.backgroundColor = .orange
        lab.layer.masksToBounds = true
        lab.layer.cornerRadius = 4
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        self.imgView.addSubview(self.categoryLab)
        self.categoryLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.width.equalTo(20)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imgView.snp.bottom)
            make.height.equalTo(20)
        }
        
        addSubview(self.subLab)
        self.subLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLab.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    var recommendliveData: CYFMLiveModel? {
        didSet {
            guard let model = recommendliveData else {
                return
            }
            
            if model.coverMiddle != nil {
                self.imgView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            
            self.titleLab.text = model.nickname
            self.subLab.text = model.name
            self.categoryLab.text = model.categoryName
        }
    }
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {
                return
            }
            self.imgView.kf.setImage(with: URL(string: model.coverMiddle!))
            self.titleLab.text = model.name
            self.subLab.text = model.nickname
        }
    }
    
}
