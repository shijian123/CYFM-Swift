//
//  CYFMHomeBroadcastController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

let CYFMHomeBroadcastSectionTel     = 0   // 电台section
let CYFMHomeBroadcastSectionMoreTel = 1   // 可展开电台section
let CYFMHomeBroadcastSectionLocal   = 2   // 本地section
let CYFMHomeBroadcastSectionRank    = 3   // 排行榜section

class CYFMHomeBroadcastController: CYBaseController {

    private let CYFMRadioHeaderViewID = "CYFMRadioHeaderView"
    private let CYFMRadioFooterViewID = "CYFMRadioFooterView"
    private let CYFMHomeRadiosCellID = "CYFMHomeRadiosCell"
    private let CYFMRadioCategoriesCellID = "CYFMRadioCategoriesCell"
    private let CYFMRadioSquareResultsCellID   = "CYFMRadioSquareResultsCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .white
        collectionV.register(CYFMRadioHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMRadioHeaderViewID)
        collectionV.register(CYFMRadioFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMRadioFooterViewID)
        collectionV.register(CYFMHomeRadiosCell.self, forCellWithReuseIdentifier: CYFMHomeRadiosCellID)
        collectionV.register(CYFMRadioCategoriesCell.self, forCellWithReuseIdentifier: CYFMRadioCategoriesCellID)
        collectionV.register(CYFMRadioSquareResultsCell.self, forCellWithReuseIdentifier: CYFMRadioSquareResultsCellID)

        collectionV.cyHead = CYRefreshHeader{ [weak self] in self?.setUpLoadData() }
        return collectionV
    }()
    
    lazy var viewModel: CYFMHomeBroadcastViewModel = {
        return CYFMHomeBroadcastViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        self.collectionView.cyHead.beginRefreshing()
    }
    
    func setUpLoadData() {
        viewModel.updataBlock = {[weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.cyHead.endRefreshing()
        }
        viewModel.refreshDataSource()
    }
}

extension CYFMHomeBroadcastController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case CYFMHomeBroadcastSectionTel: // 顶部电台
            let cell:CYFMRadioSquareResultsCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMRadioSquareResultsCellID, for: indexPath) as! CYFMRadioSquareResultsCell
            cell.radioSquareResultsModel = viewModel.radioSquareResults
            cell.delegate = self
            return cell
        case CYFMHomeBroadcastSectionMoreTel: // 可展开更多的电台
            let identifier:String = "\(indexPath.section)\(indexPath.row)"
            self.collectionView.register(CYFMRadioCategoriesCell.self, forCellWithReuseIdentifier: identifier)
            let cell:CYFMRadioCategoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CYFMRadioCategoriesCell
            cell.backgroundColor = UIColor.init(red: 248/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
            cell.dataSource = viewModel.categories?[indexPath.row].name
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 2
            return cell
        default:
            let cell:CYFMHomeRadiosCell = collectionView.dequeueReusableCell(withReuseIdentifier: CYFMHomeRadiosCellID, for: indexPath) as! CYFMHomeRadiosCell
            if indexPath.section == CYFMHomeBroadcastSectionLocal{ // 本地电台
                cell.localRadioModel = viewModel.localRadios?[indexPath.row]
            }else {
                cell.topRadioModel = viewModel.topRadios?[indexPath.row]
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: CYFMRadioHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CYFMRadioHeaderViewID, for: indexPath) as! CYFMRadioHeaderView
            headerView.titStr = viewModel.titleArray[indexPath.section - 2]
            headerView.backgroundColor = .white
            return headerView
        }else {
            let footerView: CYFMRadioFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CYFMRadioFooterViewID, for: indexPath) as! CYFMRadioFooterView
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 7 {
                if viewModel.isUnfold {
                    let categoryId:Int = (viewModel.categories?[indexPath.row].id)!
                    let title = viewModel.categories?[indexPath.row].name
                    let vc = CYFMBroadcastListController(url: nil, categoryId: categoryId,isMoreCategory:true)
                    vc.title = title
                    navigationController?.pushViewController(vc, animated: true)
                }else {
                    viewModel.isUnfold = true
                    viewModel.categories?.remove(at: 7)
                    viewModel.categories?.insert(viewModel.coverModel, at: 14)
                    self.collectionView.reloadData()
                }
            }else if indexPath.row == 15{
                if viewModel.isUnfold{
                    viewModel.isUnfold = false
                    viewModel.categories?.remove(at: 14)
                    viewModel.categories?.insert(viewModel.bottomModel, at: 7)
                    self.collectionView.reloadData()
                }else {
                    
                }
            }else{
                let categoryId:Int = (viewModel.categories?[indexPath.row].id)!
                let title = viewModel.categories?[indexPath.row].name
                let vc = CYFMBroadcastListController(url: nil, categoryId: categoryId,isMoreCategory:true)
                vc.title = title
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

extension CYFMHomeBroadcastController: CYFMRadioSquareResultsCellDelegate {
    func radioSquareResultsCellItemClick(url: String, title: String) {
        if title == "主播直播" {
            let vc = CYFMHomeLiveController()
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }else if title == "省市台"{
            
        }else {
            // 截取参数
            let split = url.components(separatedBy: ".com")
            let string = split[1]
            let vc = CYFMBroadcastListController(url: string, categoryId: 0, isMoreCategory:false)
            vc.title = title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

