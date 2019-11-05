//
//  CYRecommendLiveCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYRecommendLiveCell: UICollectionViewCell {
    private var imgView: UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 8
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    private var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        return lab
    }()
    
    private var subLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = .gray
        return lab
    }()
    
    private var categoryLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = .white
        lab.backgroundColor = .orange
        lab.layer.masksToBounds = true
        lab.layer.cornerRadius = 4
        return lab
    }()
    
    private var replicatorLayer: CYReplicatorLayer = {
       let layer = CYReplicatorLayer(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
        return layer
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
            make.left.top.equalToSuperview()
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
    
    var recommendLiveData: CYFMLiveModel? {
        didSet {
            guard let model = recommendLiveData else { return }
            if model.coverMiddle != nil {
                self.imgView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLab.text = model.nickname
            self.subLab.text = model.name
            self.categoryLab.text = model.categoryName
        }
    }
    
    var liveData: CYFMLiveModel? {
        didSet{
            guard let model = liveData else { return }
            if model.coverMiddle != nil {
                self.imgView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            
            self.titleLab.text = model.nickname
            self.subLab.text = model.name
            self.categoryLab.text = model.categoryName
            
        }
    }
}
