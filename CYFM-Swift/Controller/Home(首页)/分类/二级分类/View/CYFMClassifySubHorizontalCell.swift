//
//  CYFMClassifySubHorizontalCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubHorizontalCell: UICollectionViewCell {
    private var imgView: UIImageView = {
        let imgV = UIImageView()
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
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayput()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayput() {
        addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
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
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else { return }
            self.imgView.kf.setImage(with: URL(string: model.coverMiddle!))
            self.titleLab.text = model.title
            self.subLab.text = model.intro
        }
    }
    
    var classifyModuleType20Model: CYFMClassifyModuleType20List? {
        didSet {
            guard let model = classifyModuleType20Model else {
                return
            }
            self.imgView.kf.setImage(with: URL(string: model.albumCoverUrl290!))
            self.titleLab.text = model.title
            self.subLab.text = model.intro
        }
    }
    
}
