//
//  CYFMBroadcastListController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/31.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMBroadcastListController: CYBaseController {
    private var topRadiosModel:[CYFMTopRadiosModel]?
    private let CYFMHomeRadiosCellID = "CYFMHomeRadiosCell"
    
    private var url: String?
    private var categoryId: Int = 0
    private var isMoreCategory: Bool = false
    
    convenience init(url: String?, categoryId: Int = 0, isMoreCategory: Bool = false) {
        self.init()
        self.url = url
        self.categoryId = categoryId
        self.isMoreCategory = isMoreCategory
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionV
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setUpLoadData() {
        
    }
    

}

//extension CYFMBroadcastListController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
