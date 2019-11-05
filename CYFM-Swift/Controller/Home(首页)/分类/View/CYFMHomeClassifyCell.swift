//
//  CYFMHomeClassifyCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/28.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMHomeClassifyCell: UICollectionViewCell {
    lazy var imgView: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
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
            make.left.equalTo(10)
            make.width.height.equalTo(25)
            make.centerY.equalToSuperview()
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.imgView.snp.right).offset(5)
            make.top.bottom.equalTo(self.imgView)
            make.width.equalToSuperview().offset(-self.imgView.frame.width)
        }
        
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        layer.borderWidth = 0.5
    }
    
    var itemModel: CYFMItemList? {
        didSet {
            guard let model = itemModel else { return }
            
            if model.itemType == 1 {// 如果是第一个item。 有图片显示且字体偏小
                self.titleLab.text = model.itemDetail?.keywordName
            }else {
                self.titleLab.text = model.itemDetail?.title
                self.imgView.kf.setImage(with: URL(string: model.coverPath!))
            }
        }
    }
    
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else { return }
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
                if indexPath.row == 0 {
                    self.titleLab.font = UIFont.systemFont(ofSize: 13)
                }else {
                    self.imgView.snp.makeConstraints { (make) in
                        make.left.equalToSuperview()
                        make.width.equalTo(0)
                    }
                    
                    self.titleLab.snp.makeConstraints { (make) in
                        make.left.equalTo(self.imgView.snp.right)
                        make.width.equalToSuperview()
                    }
                    
                    self.titleLab.textAlignment = .center
                }
            }
        }
    }
    
}
