//
//  CYFMClassifySubRecommendController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/29.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMClassifySubRecommendController: CYBaseController {

    private var categoryId: Int = 0
    
    convenience init(categoryId: Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    
    private var CYFMClassifySubHeaderViewID = "CYFMClassifySubHeaderView"
    private var CYFMClassifySubFooterViewID = "CYFMClassifySubFooterView"
    
    private var CYFMClassifySubHeaderCellID = "CYFMClassifySubHeaderCell"
    private var CYFMClassifySubHorizontalCellID = "CYFMClassifySubHorizontalCell"
    private var CYFMClassifySubVerticalCellID = "CYFMClassifySubVerticalCell"
    private var CYFMClassifySubModuleType20CellID = "CYFMClassifySubModuleType20Cell"
    private var CYFMClassifySubModuleType19CellID = "CYFMClassifySubModuleType19Cell"
    private var CYFMClassifySubModuleType17CellID = "CYFMClassifySubModuleType17Cell"
    private var CYFMClassifySubModuleType4CellID = "CYFMClassifySubModuleType4Cell"
    private var CYFMClassifySubModuleType16CellID = "CYFMClassifySubModuleType16Cell"
    private var CYFMClassifySubModuleType23CellID = "CYFMClassifySubModuleType23Cell"

    private lazy var myCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        
        collectionV.register(CYFMClassifySubHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMClassifySubHeaderViewID)
        collectionV.register(CYFMClassifySubFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMClassifySubFooterViewID)
        
        collectionV.register(CYFMClassifySubHeaderCell.self, forCellWithReuseIdentifier: CYFMClassifySubHeaderCellID)
        collectionV.register(CYFMClassifySubHorizontalCell.self, forCellWithReuseIdentifier: CYFMClassifySubHorizontalCellID)
        collectionV.register(CYFMClassifySubVerticalCell.self, forCellWithReuseIdentifier: CYFMClassifySubVerticalCellID)
        collectionV.register(CYFMClassifySubModuleType23Cell.self, forCellWithReuseIdentifier: CYFMClassifySubModuleType23CellID)
        collectionV.register(CYFMClassifySubModuleType20Cell.self, forCellWithReuseIdentifier: CYFMClassifySubModuleType20CellID)
        collectionV.register(CYFMClassifySubModuleType19Cell.self, forCellWithReuseIdentifier: CYFMClassifySubModuleType19CellID)
        collectionV.register(CYFMClassifySubModuleType17Cell.self, forCellWithReuseIdentifier: CYFMClassifySubModuleType17CellID)
        collectionV.register(CYFMClassifySubModuleType16Cell.self, forCellWithReuseIdentifier: CYFMClassifySubModuleType16CellID)
        collectionV.register(CYFMClassifySubModuleType4Cell.self, forCellWithReuseIdentifier: CYFMClassifySubModuleType4CellID)

        collectionV.cyHead = CYRefreshHeader{[weak self] in
            self?.setupLoadData()
        }
        return collectionV
    }()

    lazy var viewModel: CYFMClassifySubRecommendViewModel = {
        return CYFMClassifySubRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.myCollectionV)
        self.myCollectionV.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.myCollectionV.cyHead.beginRefreshing()
//        setupLoadData()
    }
    
    func setupLoadData() {
        viewModel.categoryId = self.categoryId
        viewModel.updataBlock = {[weak self] in
            self?.myCollectionV.cyHead.endRefreshing()
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

extension CYFMClassifySubRecommendController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: CYFMClassifySubHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMClassifySubHeaderViewID, for: indexPath) as! CYFMClassifySubHeaderView
            headerView.classifyCategoryContents = viewModel.classifyCategoryContentsList?[indexPath.section]
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: CYFMClassifySubFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMClassifySubFooterViewID, for: indexPath) as! CYFMClassifySubFooterView
            return footerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardClass = viewModel.classifyCategoryContentsList?[indexPath.section].cardClass
        let moduleType = viewModel.classifyCategoryContentsList?[indexPath.section].moduleType
        
        if moduleType == 14 {
            let cell: CYFMClassifySubHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubHeaderCellID, for: indexPath) as! CYFMClassifySubHeaderCell
            
            return cell
        }else if moduleType == 3 {
            if cardClass == "horizontal" {
                let cell: CYFMClassifySubHorizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubHorizontalCellID, for: indexPath) as! CYFMClassifySubHorizontalCell
                return cell
            }else {
                let cell: CYFMClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubVerticalCellID, for: indexPath) as! CYFMClassifySubVerticalCell
                return cell
            }
        }else if moduleType == 5 {
            if cardClass == "horizontal" {
                let cell: CYFMClassifySubHorizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubHorizontalCellID, for: indexPath) as! CYFMClassifySubHorizontalCell
                return cell
            }else {
                let cell: CYFMClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubVerticalCellID, for: indexPath) as! CYFMClassifySubVerticalCell
                return cell
            }
        }else if moduleType == 23 {
            let cell: CYFMClassifySubModuleType23Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubModuleType23CellID, for: indexPath) as! CYFMClassifySubModuleType23Cell
            return cell
        }else if moduleType == 20 {
            let cell: CYFMClassifySubModuleType20Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubModuleType20CellID, for: indexPath) as! CYFMClassifySubModuleType20Cell
            return cell
        }else if moduleType == 19 {
            let cell: CYFMClassifySubModuleType19Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubModuleType19CellID, for: indexPath) as! CYFMClassifySubModuleType19Cell
            return cell
        }else if moduleType == 17 {
            let cell: CYFMClassifySubModuleType17Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubModuleType17CellID, for: indexPath) as! CYFMClassifySubModuleType17Cell
            return cell
        }else if moduleType == 16 {
            let cell: CYFMClassifySubModuleType16Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubModuleType16CellID, for: indexPath) as! CYFMClassifySubModuleType16Cell
            return cell
        }else if moduleType == 4 {
            let cell: CYFMClassifySubModuleType4Cell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubModuleType4CellID, for: indexPath) as! CYFMClassifySubModuleType4Cell
            return cell
        }else if moduleType == 18 {
            let cell: CYFMClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubVerticalCellID, for: indexPath) as! CYFMClassifySubVerticalCell
            return cell
        }else {
            let cell: CYFMClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMClassifySubVerticalCellID, for: indexPath) as! CYFMClassifySubVerticalCell
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = viewModel.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row].albumId ?? 0
        let vc = CYFMPlayController(albumId: albumId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
