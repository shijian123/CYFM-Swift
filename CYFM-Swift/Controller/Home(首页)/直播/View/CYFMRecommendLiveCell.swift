//
//  CYFMRecommendLiveCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/20.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMRecommendLiveCell: UICollectionViewCell {
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView()
        imgV.layer.masksToBounds = true
        imgV.layer.cornerRadius = 8.0
        return imgV
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var subLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 14)
        lab.textColor = .lightGray
        lab.numberOfLines = 0
        return lab
    }()
    
    private lazy var categoryLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 12)
        lab.textColor = .white
        lab.backgroundColor = .orange
        lab.layer.masksToBounds = true
        lab.layer.cornerRadius = 4.0
        return lab
    }()
    
    private var replicatorLayer: CYReplicatorLayer = {
        return CYReplicatorLayer(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.imgView.addSubview(self.categoryLab)
        self.categoryLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(20)
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
        
        self.imgView.addSubview(self.replicatorLayer)
        self.replicatorLayer.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(10)
        }
    }
    
    var liveModel: CYFMLivesModel? {
        didSet {
            guard let model = liveModel else {
                return
            }
            
            if model.coverMiddle != nil {
                self.imgView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLab.text = model.nickname
            self.subLab.text = model.name
            self.categoryLab.text = model.categoryName
        }
    }
    
}
