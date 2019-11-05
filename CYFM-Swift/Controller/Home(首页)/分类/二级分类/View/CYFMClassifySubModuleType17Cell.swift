//
//  CYFMClassifySubModuleType17Cell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubModuleType17Cell: UICollectionViewCell {
    private var imgView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
    }
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {
                return
            }
            self.imgView.kf.setImage(with: URL(string: model.coverPath!))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
