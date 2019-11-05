//
//  Array+CY.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

import Darwin

public extension Array {
    
    /**
     Returns a random element from the array. Can be used to create a playful
     */
    func cy_random() -> Iterator.Element? {
        guard count > 0 else { return nil }
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}
