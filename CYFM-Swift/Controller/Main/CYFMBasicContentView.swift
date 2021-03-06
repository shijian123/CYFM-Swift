//
//  CYFMBasicContentView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import ESTabBarController_swift

class CYFMBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0/255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255/0, blue: 42/255/0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0/255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
