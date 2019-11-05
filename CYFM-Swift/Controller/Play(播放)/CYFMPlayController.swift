//
//  CYFMPlayController.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit

class CYFMPlayController: CYBaseController {

    private var albumId: Int = 0
    private var trackUid: Int = 0
    private var uid: Int = 0
    
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid: Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
