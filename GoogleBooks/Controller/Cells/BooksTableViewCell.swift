//
//  BooksTableViewCell.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    @IBOutlet weak var _imageBook: UIImageView!
    @IBOutlet weak var _labelTitle: UILabel!
    @IBOutlet weak var _buttonPending: UIButton!
    @IBOutlet weak var _labelRating: UILabel!
    @IBOutlet weak var _imageRating: UIImageView!
     var currentRow: Int!
    
    weak var delegateViewController: ProtocolFilterApply?
    
    func setDesignForRow(array:[VolumeInfo],row:Int){
        let volumeInfo = array[row]
        currentRow = row
        _labelTitle.text = volumeInfo.title
        let imageLinks = volumeInfo.imageLinks
        prepareForReuse()
        _imageBook.hnk_setImageFromURL(URL(string:(imageLinks?.thumbnail)!)!)
        if(volumeInfo.averageRating > 0){
            _labelRating.text = String(volumeInfo.averageRating)
            _labelRating.isHidden = false
            _imageRating.isHidden = false
        }else{
            _labelRating.isHidden = true
            _imageRating.isHidden = true
        }
        if(volumeInfo.items?.isPending)!{
            _buttonPending.isSelected = false //pending
        }else{
            _buttonPending.isSelected = true //read
        }
    }
    
    @IBAction func btnPendingClicked(_ sender:UIButton){
        if(sender.isSelected){
            sender.isSelected = false //pending
        }else{
            sender.isSelected = true //read
        }
        delegateViewController?.bookStatusUpdated(status: !sender.isSelected,row: currentRow)
    }
    
}
