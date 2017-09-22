//
//  FilterViewController.swift
//  GoogleBooks
//
//  Created by mac on 21/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import UIKit
import TTRangeSlider

class FilterViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    @IBOutlet weak var _collectionViewCategories: UICollectionView!
    @IBOutlet weak var _rangeSliderDate: TTRangeSlider!
    @IBOutlet weak var _rangeSliderPages: TTRangeSlider!
    
    weak var delegateFilter :ProtocolFilterApply?
    var allCategories = [Categories]()
    var arrayForCats = [String]()
    var minDateString = Constants.MIN_DATE
    var maxDateString = Constants.MAX_DATE
    var minPages = Constants.MIN_PAGES
    var maxPages = Constants.MAX_PAGES
    
    override func viewDidLoad() {
        _rangeSliderDate.tintColorBetweenHandles = ViewDesign.selectedColor
        _rangeSliderDate.delegate = self
        _rangeSliderDate.tag = Constants.DATES
        _rangeSliderDate.handleColor = ViewDesign.selectedColor
        
        _rangeSliderPages.tintColorBetweenHandles = ViewDesign.selectedColor
        _rangeSliderPages.delegate = self
        _rangeSliderDate.tag = Constants.PAGES
        _rangeSliderPages.handleColor = ViewDesign.selectedColor
        
        allCategories = BooksManager.sharedInstance.getAllCategories()
        _collectionViewCategories.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! FilterCollectionCell
        cell.setDesignForCell(title: allCategories[indexPath.row].categories!)
        cell.setCategoryUI(array: arrayForCats, button: cell._buttonFilterType)
        cell.delegateSelectedCatProtocol = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = allCategories[indexPath.row]
        return CGSize(width: (category.categories?.size().width)!, height: 50)
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func btnApplyClicked(_ sender: Any) {
        if(checkIfAnyFilter()){
            let cats = arrayForCats.joined(separator: " ")
            delegateFilter?.applySelectedFilters(cats: cats, minDate: Int(minDateString), maxDate: Int(maxDateString), minPage: Int(minPages), maxPage: Int(maxPages))
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnClearAllClicked(_ sender: Any) {
        arrayForCats.removeAll()
        delegateFilter?.filterCleared()
        _collectionViewCategories.reloadData()
        resetUIAndData()
        
        
    }
    
}

extension FilterViewController:ProtocolSelectedCategory,TTRangeSliderDelegate{
    func getSelectedCategories(cat: String) {
            arrayForCats.append(cat)
    }
    func removeSelectedCategories(cat: String) {
        if let index = arrayForCats.index(of: cat){
            arrayForCats.remove(at: index)
        }
        
    }
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        if(sender.tag == Constants.DATES){
            minDateString = selectedMinimum
            maxDateString = selectedMaximum

        }else{
            minPages = selectedMinimum
            maxPages = selectedMaximum
        }
    }
    
    func resetUIAndData(){
        _rangeSliderDate.selectedMinimum = Constants.MIN_DATE
        _rangeSliderDate.selectedMaximum = Constants.MAX_DATE
        _rangeSliderPages.selectedMinimum = Constants.MIN_PAGES
        _rangeSliderPages.selectedMaximum = Constants.MAX_PAGES
    }
    
    func checkIfAnyFilter() -> Bool{
        if(_rangeSliderDate.selectedMinimum == Constants.MIN_DATE && _rangeSliderDate.selectedMaximum == Constants.MAX_DATE && _rangeSliderPages.selectedMinimum == Constants.MIN_PAGES && _rangeSliderPages.selectedMaximum ==  Constants.MAX_PAGES && arrayForCats.count == 0){
            return false
        }else{
            return true
        }
    }
}
