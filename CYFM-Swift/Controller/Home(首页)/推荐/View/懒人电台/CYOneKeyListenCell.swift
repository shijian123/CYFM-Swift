//
//  CYOneKeyListenCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYOneKeyListenCell: UICollectionViewCell {
    private lazy var imgView: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textAlignment = .center
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
        self.imgView.snp.makeConstraints { (make) in
            make.height.width.equalTo(70)
            make.centerX.equalToSuperview()
            make.top.equalTo(15)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imgView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    
    var oneKeyListen: CYFMOneKeyListenModel? {
        didSet {
            guard let model = oneKeyListen else { return }
            if model.coverRound != nil {
                self.imgView.kf.setImage(with: URL(string: model.coverRound!))
            }
            self.titleLab.text = model.channelName
        }
    }
    
}

