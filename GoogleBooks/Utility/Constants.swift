//
//  Constants.swift
//  GoogleBooks
//
//  Created by mac on 21/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

struct Constants {
    static let MIN_DATE :Float = 1600
    static let MAX_DATE :Float = 2017
    static let MIN_PAGES :Float = 1
    static let MAX_PAGES :Float = 1500
    static let DATES = 1
    static let PAGES = 2
    static let NO_DATA = "No books found."
    static let NO_RESULT_FOUND = "No results found.Clear filters and search."
    static let LOADING = "Loading..."
    
    
}
protocol ProtocolSelectedCategory:class{
    func getSelectedCategories(cat:String)
    func removeSelectedCategories(cat:String)
    
}
protocol ProtocolFilterApply :class{
    func applySelectedFilters(cats:String,minDate:Int,maxDate:Int,minPage:Int,maxPage:Int)
    func filterCleared()
    func bookStatusUpdated(status:Bool,row:Int)
}
