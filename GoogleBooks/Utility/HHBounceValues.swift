//
//  HHBounceValues.swift
//  HeyHub
//
//  Created by mac on 02/08/17.
//  Copyright © 2017 HeyHub, Itd. All rights reserved.
//

import UIKit

class HHBounceValues: NSObject {
    var _object: UIView!
    var _originalValue :CGRect!
    var _direction : Direction!
    
    init(object:UIView,originalValue:CGRect,direction:Direction) {
        self._object = object
        self._originalValue = originalValue
        self._direction = direction
    }
}

enum Direction: Int {
    case left = 1, right, top, bottom
}
