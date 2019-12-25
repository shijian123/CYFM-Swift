//
//  CYFMHomeVIPController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/16.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

// 在viewModel中使用，增加代码的可读性
let CYFMHomeVipSectionBanner    = 0   // 滚动图片section
let CYFMHomeVipSectionGrid      = 1   // 分类section
let CYFMHomeVipSectionHot       = 2   // 热section
let CYFMHomeVipSectionEnjoy     = 3   // 尊享section
let CYFMHomeVipSectionVip       = 4   // vip section

class CYFMHomeVIPController: CYBaseController {

    // 上页面传过来请求接口必须的参数
    convenience init(isRecommendPush: Bool = false) {
        self.init()
        self.tableView.frame = CGRect(x: 0, y: 0, width: CYFMScreenWidth, height: CYFMScreenHeight)
    }
    
    private let CYFMHomeVIPCellID           = "CYFMHomeVIPCell"
    private let CYFMHomeVipHeaderViewID     = "CYFMHomeVipHeaderView"
    private let CYFMHomeVipFooterViewID     = "CYFMHomeVipFooterView"
    private let CYFMHomeVipBannerCellID     = "CYFMHomeVipBannerCell"
    private let CYFMHomeVipCategoriesCellID = "CYFMHomeVipCategoriesCell"
    private let CYFMHomeVipHotCellID        = "CYFMHomeVipHotCell"
    private let CYFMHomeVipEnjoyCellID      = "CYFMHomeVipEnjoyCell"

    
    private lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: CYFMScreenWidth, height: 30))
        view.backgroundColor = .purple
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableV = UITableView(frame: self.view.bounds, style: UITableView.Style.grouped)
        tableV.delegate = self
        tableV.dataSource = self
        tableV.backgroundColor = .white
        tableV.separatorStyle = .none
        // 注册头尾视图
        tableV.register(CYFMHomeVipHeaderView.self, forCellReuseIdentifier: CYFMHomeVipHeaderViewID)
        tableV.register(CYFMHomeVipFooterView.self, forCellReuseIdentifier: CYFMHomeVipFooterViewID)
        
        // 注册分区Cell
        tableV.register(CYFMHomeVIPCell.self, forCellReuseIdentifier: CYFMHomeVIPCellID)
        tableV.register(CYFMHomeVipBannerCell.self, forCellReuseIdentifier: CYFMHomeVipBannerCellID)
        tableV.register(CYFMHomeVipCategoriesCell.self, forCellReuseIdentifier: CYFMHomeVipCategoriesCellID)
        tableV.register(CYFMHomeVipHotCell.self, forCellReuseIdentifier: CYFMHomeVipHotCellID)
        tableV.register(CYFMHomeVipEnjoyCell.self, forCellReuseIdentifier: CYFMHomeVipEnjoyCellID)
        tableV.cyHead = CYRefreshHeader{ [weak self] in
            self?.setupLoadData()
        }
        return tableV
    }()
    
    lazy var viewModel: CYFMHomeVipViewModel = {
        return CYFMHomeVipViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func setupLoadData() {
        viewModel.updateBlock = {[weak self] in
            self?.tableView.cyHead.endRefreshing()
            self?.tableView.reloadData()
        }
        // 发起网络请求
        self.viewModel.refreshDataSource()
        
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

extension CYFMHomeVIPController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case CYFMHomeVipSectionBanner:
            let cell: CYFMHomeVipBannerCell = tableView.dequeueReusableCell(withIdentifier: CYFMHomeVipBannerCellID, for: indexPath) as! CYFMHomeVipBannerCell
            cell.vipBannerList = viewModel.focusImages
            cell.delegate = self
            return cell
        case CYFMHomeVipSectionGrid:
            let cell: CYFMHomeVipCategoriesCell = tableView.dequeueReusableCell(withIdentifier: CYFMHomeVipCategoriesCellID, for: indexPath) as! CYFMHomeVipCategoriesCell
            cell.categoryBtnModel = viewModel.categoryBtnList
            cell.delegate = self
            return cell
            
        case CYFMHomeVipSectionHot:
            let cell: CYFMHomeVipHotCell = tableView.dequeueReusableCell(withIdentifier: CYFMHomeVipHotCellID, for: indexPath) as! CYFMHomeVipHotCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        case CYFMHomeVipSectionEnjoy:
            let cell: CYFMHomeVipEnjoyCell = tableView.dequeueReusableCell(withIdentifier: CYFMHomeVipEnjoyCellID, for: indexPath) as! CYFMHomeVipEnjoyCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        default:
            let cell: CYFMHomeVIPCell = tableView.dequeueReusableCell(withIdentifier: CYFMHomeVIPCellID, for: indexPath) as! CYFMHomeVIPCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list?[indexPath.row]
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.categoryList?[indexPath.section].list?[indexPath.row]
        let vc = CYFMPlayDetailController(albumId: model!.albumId)
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerV: CYFMHomeVipHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CYFMHomeVipHeaderViewID) as! CYFMHomeVipHeaderView
        headerV.titleStr = viewModel.categoryList?[section].title
        return headerV
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = CYFMDownColor
        return view
    }
    
}

extension CYFMHomeVIPController: CYFMHomeVipBannerCellDelegate {
    func homeVipBannerCellClick(url: String) {
        self.showNoFunctionWarning()
    }
}

// - 点击顶部分类按钮 delegate
extension CYFMHomeVIPController: CYFMHomeVipCategoriesCellDelegate {
    func homeVipCategoriesCellItemClick(id: String, url: String, title: String) {
        if url == "" {
            let vc = CYFMClassifySubMenuController(categoryId: Int(id)!, isVipPush: true)
            vc.title = title
            navigationController?.pushViewController(vc, animated: true)
        }else {
//            let vc = CYFMweb
        }
    }
}

extension CYFMHomeVIPController: CYFMHomeVipHotCellDelegate {
    func homeVipHotCellItemClick(model: CYFMCategoryContents) {
        
    }
}

extension CYFMHomeVIPController: CYFMHomeVipEnjoyCellDelegate {
    func homeVipEnjoyCellItemClick(model: CYFMCategoryContents) {
        
    }
}
