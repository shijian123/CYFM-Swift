//
//  CYFMRadioSquareCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMRadioSquareCell: UICollectionViewCell {
    private lazy var imgView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLab : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        self.addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imgView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    
    var radioSquareModel: CYFMRadioSquareResultsModel? {
        didSet {
            guard let model = radioSquareModel else {return}
            self.imgView.kf.setImage(with: URL(string: model.icon!))
            self.titleLab.text = model.title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
