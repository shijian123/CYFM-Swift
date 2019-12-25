//
//  CYFMWebViewController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/12/25.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import WebKit

class CYFMWebViewController: CYBaseController {

    private var url: String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }

    private lazy var progressView: UIProgressView = {
        let progressV = UIProgressView(frame: CGRect(x: 0, y: 0, width: CYFMScreenWidth, height: 1))
        progressV.trackTintColor = .lightGray
        progressV.progressTintColor = .systemRed
        progressV.progress = 0.0
        return progressV
    }()
    
    private lazy var webView: WKWebView = {
        let webV = WKWebView(frame: self.view.bounds)
        webV.uiDelegate = self
        webV.navigationDelegate = self
//        webV.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservedChange, context: <#T##UnsafeMutableRawPointer?#>)
        return webV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.webView)
        webView.load(URLRequest(url: URL(string: self.url)!))
        
        view.addSubview(self.progressView)
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

extension CYFMWebViewController: WKUIDelegate, WKNavigationDelegate {
    
}
