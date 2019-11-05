//
//  CYFMIrregularityBasicContentView.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class CYFMIrregularityBasicContentView: CYFMBouncesContentView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0/255.0, alpha: 1.0)
        highlightTextColor = UIColor.gray
        iconColor = UIColor.init(white: 175.0/255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}

class CYFMIrregularityContentView: ESTabBarItemContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = UIColor(red: 250/255.0, green: 48/255.0, blue: 32/255.0, alpha: 1.0)
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor(white: 235/255.0, alpha: 1.0).cgColor
        imageView.layer.cornerRadius = 25
        insets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        imageView.transform = transform
        superview?.bringSubviewToFront(self)
        
        textColor = .white
        highlightTextColor = .white
        iconColor = .white
        highlightIconColor = .white

        backgroundColor = .clear
        highlightBackdropColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint(x: point.x-imageView.frame.origin.x, y: point.y-imageView.frame.origin.y)
        
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        imageView.sizeToFit()
        imageView.center = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0)
        
    }
    
}
