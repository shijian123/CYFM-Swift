//
//  CYFMLiveHeaderGridCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMLiveHeaderGridCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
           let imageV = UIImageView()
           return imageV
       }()
       
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = .center
        return lab
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    func setupLayout() {
        addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
       
    var imageUrl: String? {
        didSet {
            self.imageView.kf.setImage(with: URL(string: imageUrl!))
        }
    }
    
    var titleStr: String? {
        didSet {
            self.titleLab.text = titleStr
        }
    }
}
