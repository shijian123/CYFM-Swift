//
//  CYFMClassifySubModuleType20Cell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubModuleType20Cell: UICollectionViewCell {
    private var albums: [CYFMClassifyModuleType20List]?
    
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 22)
        lab.textColor = .black
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var moreBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("-(查看更多)-", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private lazy var myCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (CYFMScreenWidth - 40) / 3, height: 180)
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.register(CYFMClassifySubHorizontalCell.self, forCellWithReuseIdentifier: "CYFMClassifySubHorizontalCell")
        return collectionV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .white
        addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(100)
        }
        
        addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLab.snp.bottom).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        addSubview(self.myCollectionV)
        self.myCollectionV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.imgView.snp.bottom).offset(15)
        }
    }
    
    var classifyVerticalModel: CYFMClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {
                return
            }
            self.imgView.kf.setImage(with: URL(string: model.coverPathBig!))
            self.titleLab.text = model.title
            self.albums = model.albums
            self.myCollectionV.reloadData()
        }
    }
}

extension CYFMClassifySubModuleType20Cell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMClassifySubHorizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CYFMClassifySubHorizontalCell", for: indexPath) as! CYFMClassifySubHorizontalCell
        cell.classifyModuleType20Model = self.albums?[indexPath.row]
        return cell
    }
    
    
}
