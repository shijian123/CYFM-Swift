//
//  CYFMLiveRankCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMLiveRankCell: UICollectionViewCell {
    private lazy var imageView : UIView = {
        let imageView = UIView()
        return imageView
    }()
    
    private lazy var titleLab : UILabel = {
       let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 18)
        return lab
    }()
    
    private lazy var moreLab : UILabel = {
        let lab = UILabel()
        lab.text = ">"
        lab.textColor = UIColor.lightGray
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
        }
        
        addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(180)
        }
        
        imageView.addSubview(self.moreLab)
        self.moreLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.width.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var multidimensionalRankVos: CYFMMultidimensionalRankVosModel? {
        didSet {
            guard let model = multidimensionalRankVos else {
                return
            }
            self.titleLab.text = model.dimensionName

            let num: Int = model.ranks?.count ?? 0
            let margin = 50
            
            for index in 0..<num {
                let picView = UIImageView(frame: CGRect(x: margin*index+5*index, y: 5, width: margin, height: margin))
                picView.layer.masksToBounds = true
                picView.layer.cornerRadius = picView.frame.size.width/2
                picView.kf.setImage(with: URL(string: (model.ranks?[index].coverSmall!)!))
                self.imageView.addSubview(picView)
            }
        }
    }
    
}
