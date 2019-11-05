//
//  CYFMOneKeyListenCell.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMOneKeyListenCell: UICollectionViewCell {
    private var oneKeyListen: [CYFMOneKeyListenModel]?
    private lazy var changeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("换一批", for: .normal)
        btn.setTitleColor(CYFMButtonColor, for: .normal)
        btn.backgroundColor = CYFMButtonBackgroundColor
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(updataBtnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (CYFMScreenWidth - 45)/3, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(CYOneKeyListenCell.self, forCellWithReuseIdentifier: "CYOneKeyListenCell")
        return collectionView
    }()
    
    @objc func updataBtnClick(sender: UIButton) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    var oneKeyListenList: [CYFMOneKeyListenModel]? {
        didSet {
            guard let modelList = oneKeyListenList else { return }
            self.oneKeyListen = modelList
            self.gridView.reloadData()
        }
    }
    
}

extension CYFMOneKeyListenCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.oneKeyListen?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CYOneKeyListenCell", for: indexPath) as! CYOneKeyListenCell
        cell.oneKeyListen = self.oneKeyListen?[indexPath.row]
        return cell
    }    
}
