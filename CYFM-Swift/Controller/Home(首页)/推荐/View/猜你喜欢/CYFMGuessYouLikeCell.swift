//
//  CYFMGuessYouLikeCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMGuessYouLikeCell: UICollectionViewCell {
    
    // 图片
    private var myImageV: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    // 标题
    private var titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // 子标题
    private var subLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        addSubview(self.myImageV)
        self.myImageV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.myImageV.snp.bottom)
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
    
    var recommendData: CYFMRecommendListModel? {
        didSet {
            guard let model = recommendData else { return }
            
            if model.pic != nil {
                self.myImageV.kf.setImage(with: URL(string: model.pic!))
            }
            self.titleLab.text = model.title;
            self.subLab.text = model.subtitle
        }
    }
    
    
}
