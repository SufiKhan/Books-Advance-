//
//  ViewController.swift
//  GoogleBooks
//
//  Created by mac on 16/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import UIKit
import CoreData
import Haneke

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var _textFieldSearch: UITextField!
    @IBOutlet weak var _tableViewBooks: UITableView!
    var arrayBooks = [VolumeInfo]()
    var arrayFiltered = [VolumeInfo]()
    var arraySearched = [VolumeInfo]()
    var arrayToDisplay = [VolumeInfo]()
    var accessInfo = [AccessInfo]()
    @IBOutlet weak var _labelAlert: UILabel!
    lazy var context :NSManagedObjectContext = {
        return CoreDataManager.sharedInstance.getContext()
    }()
    lazy var detailViewController :DetailViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    }()
    
    lazy var filterViewController :FilterViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewDesign.sharedInstance.setUIForView(parentView: self)
        getInitialData()
        
    }
    
    func getInitialData(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: BooksManager.ITEMS)
        do{
            let count = try context.count(for: fetchRequest)
            if(count == 0){
                getBookListFromServer()
            }else{
                getBooksFromCoreData(req: fetchRequest)
                getAccessInfoFromCoreData(req: fetchRequest)
            }
        }catch{}
    }
    
    func getBookListFromServer(){
        _labelAlert.text = Constants.LOADING
        _labelAlert.isHidden = false
        BooksNetworkUtility().getBooksList{ (result) in
            switch result{
            case .Success(let data):
                BooksManager.sharedInstance.saveJsonToCoreData(array: data, callback: { (saved) in
                    if(saved){
                        self.getInitialData()
                    }
                })
            case .Error( _):
                self._labelAlert.isHidden = false
            }
        }
    }
    
    func getBooksFromCoreData(req :NSFetchRequest<NSFetchRequestResult>){
        let entity = NSEntityDescription.entity(forEntityName: "VolumeInfo", in: context)
        req.entity = entity

        do{
            arrayBooks = try context.fetch(req) as! [VolumeInfo]
            arrayToDisplay = arrayBooks
            _tableViewBooks.reloadData()
        }catch{}
    }
    func getAccessInfoFromCoreData(req :NSFetchRequest<NSFetchRequestResult>){
        let entity = NSEntityDescription.entity(forEntityName: "AccessInfo", in: context)
        req.entity = entity
        do{
           accessInfo = try context.fetch(req) as! [AccessInfo]
            
        }catch{}
    }
    
    @IBAction func btnRatingClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected){
            arrayToDisplay.removeAll()
            arrayToDisplay = BooksManager.sharedInstance.getTopRatedBooks()
        }else{
            arrayToDisplay.removeAll()
            arrayToDisplay = arrayBooks
        }
        _tableViewBooks.reloadData()
    }
    
    @IBAction func btnFilterClicked(_ sender: Any) {
        filterViewController.delegateFilter = self
        self.present(filterViewController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchString = textField.text
        if(string.isEmpty){
            searchString?.remove(at: (searchString?.index(before: (searchString?.endIndex)!))!)

        }else{
            searchString = textField.text?.appending(string)
        }
        if(searchString?.isEmpty)!{
            arrayToDisplay = arrayBooks
        }else{
            if((searchString?.characters.count)! >= 3){
            arrayToDisplay = BooksManager.sharedInstance.searchBooksWithKeyWord(string: searchString!)
            updateError()
            }
        }
        _tableViewBooks.reloadData()
        return true
    }
    
}


extension ViewController: UITableViewDelegate,UITableViewDataSource,ProtocolFilterApply{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayToDisplay.count > 0 {
            _labelAlert.isHidden = true
            return arrayToDisplay.count
        }else{
            _labelAlert.isHidden = false
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BooksTableViewCell
        cell.delegateViewController = self
        cell.setDesignForRow(array: arrayToDisplay,row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! BooksTableViewCell
        detailViewController.info = arrayToDisplay[indexPath.row]
        if let webLink = accessInfo[indexPath.row].webReaderLink{
            detailViewController.webReaderLink = webLink
        }
        let frame = tableView.convert(tableView.rectForRow(at: indexPath), to: tableView.superview)
        ViewDesign.sharedInstance.animateDetailViewWithLocalAssetFor(detailView: detailViewController, parentView: self, image: cell._imageBook,startingPoint: CGPoint(x: frame.midX, y: frame.midY))
        
    }
    func applySelectedFilters(cats: String, minDate: Int, maxDate: Int, minPage: Int, maxPage: Int) {
        arrayToDisplay = BooksManager.sharedInstance.getFilteredBooks(categories: cats, minDate: minDate, maxDate: maxDate, minPage: minPage, maxPage: maxPage)
        updateError()
        _tableViewBooks.reloadData()
    }
    func filterCleared() {
        arrayToDisplay = arrayBooks
        _tableViewBooks.reloadData()
    }
    func bookStatusUpdated(status: Bool,row:Int) {
        let obj = arrayToDisplay[row] as VolumeInfo
        let item = obj.items!
        if let volumeInfo = BooksManager.sharedInstance.getVolumeInfoForId(id: item.id!){
            volumeInfo.items?.setValue(status, forKey: "isPending")
            do{
                try context.save()
            }catch{
                
            }

        }
        
    }
    func updateError(){
        if(arrayToDisplay.count == 0){
            _labelAlert.text = Constants.NO_RESULT_FOUND
        }
    }
}
