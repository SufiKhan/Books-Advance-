//
//  HHBounceAnimator.swift
//  HeyHub
//
//  Created by mac on 02/08/17.
//  Copyright © 2017 HeyHub, Itd. All rights reserved.
//

import UIKit

class HHBounceAnimator {
    class func moveOffScreen(objects:[HHBounceValues],bounds:CGRect){
        for obj in objects{
            switch obj._direction! {
            case Direction.left:
                var temp = obj._object.frame
                temp.origin.x = bounds.origin.x - temp.size.width
                obj._object.frame = temp
            case Direction.right:
                var temp = obj._object.frame
                temp.origin.x = bounds.maxX
                obj._object.frame = temp
            case Direction.top:
                var temp = obj._object.frame
                temp.origin.y = bounds.minY - temp.size.height
                obj._object.frame = temp
            case Direction.bottom:
                var temp = obj._object.frame
                temp.origin.y = bounds.maxY
                obj._object.frame = temp
            }
        }
        
    }
    
    class func bounce(objects:[HHBounceValues]) {
        UIView.animate(withDuration: 1, delay: 0.4 ,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        for obj in objects{
                            obj._object.frame = obj._originalValue
                        }
        }, completion: nil)
    }
    
    class func unfadeAll(obj:UIView){
        UIView.animate(withDuration: 0.5, animations: { 
            obj.alpha = 1
        })
    }
    
    class func zoomView(view:UIView){
        view.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
        view.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            view.alpha = 1
            view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }) { (completed) in
        }
    }
}
