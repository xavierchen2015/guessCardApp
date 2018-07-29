//
//  NewButtonClass.swift
//  guessCardApp
//
//  Created by Xavier Chen [MIGOTP] on 2018/7/30.
//  Copyright © 2018年 Xavier Chen [MIGOTP]. All rights reserved.
//

import Foundation
import UIKit

//自訂 button class
class mybutton: UIButton {
    var _id: Int = 0
    var orderId: Int?
    var buttonid: Int! {
        get { return _id }
        set{ _id = newValue }
    }
    
    init(frame: CGRect, id: Int, oid: Int?) {
        self._id = id
        self.orderId = oid
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
