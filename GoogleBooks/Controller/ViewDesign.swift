//
//  ViewDesign.swift
//  GoogleBooks
//
//  Created by mac on 19/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//
import UIKit

class ViewDesign: NSObject {
    
    static let sharedInstance = ViewDesign()
    private override init() {}
    static let selectedColor = UIColor.init(colorLiteralRed: 255/255, green: 0/255, blue: 84/255, alpha: 1)
    
    
    func setUIForView(parentView:ViewController){
        let attributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName : UIFont(name: "Copperplate", size: 18)!]
        
        parentView._textFieldSearch.attributedPlaceholder = NSAttributedString(string: "SEARCH HERE", attributes: attributes)
    }
    
    func setAlphaColor(color:UIColor) ->UIColor{
        return color.withAlphaComponent(0.5)
    }
    
    
    func animateDetailViewWithLocalAssetFor(detailView:DetailViewController,parentView:ViewController,image:UIImageView,startingPoint:CGPoint){
        detailView.view.layer.cornerRadius = 20
        var viewToBounce = [HHBounceValues(object: detailView.view, originalValue: detailView.view.bounds, direction: .bottom)]
        HHBounceAnimator.moveOffScreen(objects: viewToBounce, bounds: parentView.view.bounds)
        parentView.view.addSubview(detailView.view)
        HHBounceAnimator.bounce(objects: viewToBounce)
        
        let detailImage = UIImageView()
        var temp = image.frame
        temp.origin.y = 70
        temp.origin.x += 10
        detailImage.frame = temp
        viewToBounce = [HHBounceValues(object: detailImage, originalValue: detailImage.frame, direction: .bottom)]
        detailImage.center =  startingPoint
        detailImage.image = image.image
        detailImage.layer.cornerRadius = 20
        detailImage.layer.masksToBounds = true
        detailImage.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        detailView.view.window?.addSubview(detailImage)
        detailImage.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            detailImage.alpha = 1
            detailImage.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            HHBounceAnimator.bounce(objects: viewToBounce)
        }) { (completed) in
            detailView._imageBook.image = detailImage.image
            detailImage.removeFromSuperview()
            detailView.setDetailsForBook()
        }
        
    }
    
    func closeDetailView(detailView:UIView,callback:@escaping (Bool)->()){
        UIView.animate(withDuration: 0.5, animations: {
            HHBounceAnimator.moveOffScreen(objects: [HHBounceValues(object: detailView, originalValue: detailView.frame, direction: .bottom)], bounds: (detailView.superview?.bounds)!)

        }) { (fin) in
            callback(true)
        }
    }
}
extension String {
    func size() -> CGSize {
        return (self as NSString).size(attributes: [NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 16)!])
    }
}

