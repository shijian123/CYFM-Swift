//
//  CYFMClassifySubHeaderView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubHeaderView: UICollectionReusableView {
        
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 20)
        return lab
    }()
    
    private var moreBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("更多 ⟩", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return btn
    }()
    
    private var allBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "category_rec_play_all_122x46_"), for: .normal)
        btn.isHidden = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 15
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
        addSubview(self.titleLab)
        self.titleLab.text = "猜你喜欢"
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(200)
            make.top.equalTo(5)
            make.height.equalTo(30)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(15)
            make.top.equalTo(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        addSubview(self.allBtn)
        self.allBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(5)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    var classifyCategoryContents: CYFMClassifyCategoryContentsList? {
        didSet {
            guard let model = classifyCategoryContents else { return }
            self.titleLab.text = model.title
            if model.moduleType == 19 {
                self.moreBtn.isHidden = true
                self.allBtn.isHidden = false
            }else {
                self.moreBtn.isHidden = false
                self.allBtn.isHidden = true
            }
        }
    }
}
