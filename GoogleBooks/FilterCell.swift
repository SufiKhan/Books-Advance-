//
//  FilterCell.swift
//  GoogleBooks
//
//  Created by mac on 21/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//
import UIKit

class FilterCollectionCell: UICollectionViewCell {
    @IBOutlet weak var _buttonFilterType: UIButton!
    var arraySelectedCategories : [String]?
    weak var delegateSelectedCatProtocol :ProtocolSelectedCategory?
    func setDesignForCell(title:String){
        _buttonFilterType.layer.cornerRadius = 10
        _buttonFilterType.layer.borderColor = UIColor.lightGray.cgColor
        _buttonFilterType.layer.borderWidth = 1
        _buttonFilterType.layer.masksToBounds = true
        _buttonFilterType.setTitle(title, for: .normal)
    }
    
    @IBAction func btnCategorySelected(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected){
            setSelectedStateFor(button: sender)
            delegateSelectedCatProtocol?.getSelectedCategories(cat: sender.titleLabel!.text!)
        }else{
            setDefaultStateFor(button: sender)
            delegateSelectedCatProtocol?.removeSelectedCategories(cat: sender.titleLabel!.text!)
        }
        
    }
    
    
    func setCategoryUI(array : [String],button:UIButton){
        if let _ = array.index(of: button.titleLabel!.text!){
            button.isSelected = true
            setSelectedStateFor(button: button)
        }else{
            button.isSelected = false
            setDefaultStateFor(button: button)
        }
    }
    
    func setSelectedStateFor(button: UIButton){
        button.backgroundColor = ViewDesign.selectedColor
    }
    
    func setDefaultStateFor(button:UIButton){
        button.backgroundColor = UIColor.white
    }
}
