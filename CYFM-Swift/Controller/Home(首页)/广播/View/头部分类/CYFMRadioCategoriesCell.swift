//
//  CYFMRadioCategoriesCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMRadioCategoriesCell: UICollectionViewCell {
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var titleLab : UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.font = .systemFont(ofSize: 18)
        lab.textColor = .black
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        self.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.top.equalTo(7.5)
            make.centerX.equalToSuperview()
        }
    }
    
    var dataSource: String? {
        didSet {
            guard let str = dataSource else { return }
            if (str.contains(".png")) {
                self.titleLab.text = ""
                self.imgView.image = UIImage(named: str)
            }else {
                self.imgView.image = UIImage(named: "")
                self.titleLab.text = str
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
