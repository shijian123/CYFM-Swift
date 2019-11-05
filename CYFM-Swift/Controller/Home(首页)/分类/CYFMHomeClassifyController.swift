//
//  CYFMHomeClassifyController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMHomeClassifyController: CYBaseController {

    private var CYFMHomeClassifyFooterViewID = "CYFMHomeClassifyFooterView"
    private var CYFMHomeClassifyHeaderViewID = "CYFMHomeClassifyHeaderView"
    
    lazy var myCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        collectionV.register(CYFMHomeClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMHomeClassifyHeaderViewID)
        collectionV.register(CYFMHomeClassifyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMHomeClassifyFooterViewID)
        collectionV.register(CYFMHomeClassifyCell.self, forCellWithReuseIdentifier: "CYFMHomeClassifyCellID")

        collectionV.backgroundColor = CYFMDownColor
        return collectionV
    }()
    
    lazy var viewModel: CYFMHomeClassifyViewModel = {
        return CYFMHomeClassifyViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
        view.addSubview(self.myCollectionV)
        self.myCollectionV.snp.makeConstraints { (make) in
            make.left.right.top.height.equalToSuperview()
        }
        
        setupLoadData()
        
    }
    
    func setupLoadData() {
        viewModel.updateBlock = { [weak self] in
            self?.myCollectionV.reloadData()
        }
        viewModel.refreshDataSource()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CYFMHomeClassifyController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CYFMHomeClassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CYFMHomeClassifyCellID", for: indexPath) as! CYFMHomeClassifyCell
        cell.itemModel = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let itemDetail: CYFMItemDetail = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail ?? CYFMItemDetail()
//        let categoryId: Int = itemDetail.cat
        let vc = CYFMClassifySubMenuController(categoryId: itemDetail.categoryId)
        vc.title = itemDetail.title
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: CYFMHomeClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMHomeClassifyHeaderViewID, for: indexPath) as! CYFMHomeClassifyHeaderView
            headerView.titleStr = viewModel.classifyModel?[indexPath.section].groupName
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: CYFMHomeClassifyFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMHomeClassifyFooterViewID, for: indexPath) as! CYFMHomeClassifyFooterView
            return footerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
}
