//
//  BooksParsewr.swift
//  GoogleBooks
//
//  Created by mac on 16/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import CoreData

class BooksManager :NSObject{
    static let sharedInstance = BooksManager()
    private override init() {}

    static let ITEMS = "Items"
    static let VOLUME_INFO = "VolumeInfo"
    func itemsEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataManager.sharedInstance.getContext()
        if let items = NSEntityDescription.insertNewObject(forEntityName: BooksManager.ITEMS, into: context) as? Items {
            if let obj = dictionary["kind"] as? String{
                items.kind = obj
            }
            if let obj = dictionary["id"] as? String{
                items.id = obj
            }
            if let obj = dictionary["etag"] as? String{
                items.eTag = obj
            }
            if let obj = dictionary["selfLink"] as? String{
                items.sellfLink = obj
            }
            items.isPending = true
            
            if let obj = dictionary["volumeInfo"] as? [String: AnyObject]{
                if let volume = setVolumeInfoForBook(dictionary: obj, context: context){
                    items.volumeInfo = volume
                }
            }
            if let obj = dictionary["saleInfo"] as? [String: AnyObject]{
                if let saleInfo = setSaleInfoForBook(dictionary: obj, context: context){
                    items.saleInfo = saleInfo
                }
            }
            if let obj = dictionary["accessInfo"] as? [String: AnyObject]{
                if let accessInfo = setAccessInfoForBook(dictionary: obj, context: context){
                    items.accessInfo = accessInfo
                }
            }
            return items
        }
        return nil
    }
    
    func setVolumeInfoForBook(dictionary:[String: AnyObject],context:NSManagedObjectContext) -> VolumeInfo?{
        if let volume = NSEntityDescription.insertNewObject(forEntityName: "VolumeInfo", into: context) as? VolumeInfo {
            if let obj = dictionary["title"] as? String{
                volume.title = obj
            }
            if let obj = dictionary["subtitle"] as? String{
                volume.subtitle = obj
            }
            if let obj = dictionary["publishedDate"] as? String{
                volume.publishedData = obj
            }

            if let obj = dictionary["pageCount"] as? Int{
                volume.pageCount = Int64(obj)
            }
            if let obj = dictionary["printType"] as? String{
                volume.printType = obj
            }
            if let obj = dictionary["maturityRating"] as? String{
                volume.maturityRating = obj
            }
            if let obj = dictionary["allowAnonLogging"] as? Bool{
                volume.allowAnonLogging = obj
            }
            if let obj = dictionary["contentVersion"] as? String{
                volume.contentVersion = obj
            }
            if let obj = dictionary["language"] as? String{
                volume.language = obj
            }
            if let obj = dictionary["previewLink"] as? String{
                volume.previewLink = obj
            }
            if let obj = dictionary["infoLink"] as? String{
                volume.infoLink = obj
            }
            if let obj = dictionary["canonicalVolumeLink"] as? String{
                volume.canonicalVolumeLink = obj
            }
            if let obj = dictionary["averageRating"] as? Int{
                volume.averageRating = Int16(obj)
            }

            if let obj = dictionary["categories"] as? [String]{
                if let categories = NSEntityDescription.insertNewObject(forEntityName: "Categories", into: context) as? Categories {
                    if(obj.count > 0){
                        categories.categories = obj[0]
                    }
                    volume.categories = categories
                }
            }
            if let obj = dictionary["authors"] as? [String]{
                if let author = NSEntityDescription.insertNewObject(forEntityName: "Author", into: context) as? Author {
                    if(obj.count > 0){
                        author.authors = obj[0]
                    }
                    volume.authors = author
                }
            }
            if let obj = dictionary["industryIdentifiers"] as? [String: AnyObject]{
                if let industryIdentifiers = NSEntityDescription.insertNewObject(forEntityName: "IndustryIdentifiers", into: context) as? IndustryIdentifiers {
                    if let _obj = obj["type"] as? String{
                        industryIdentifiers.type = _obj
                    }

                    if let _obj = obj["identifier"] as? String{
                        industryIdentifiers.identifier = _obj
                    }
                    volume.industryIdentifiers = industryIdentifiers
                }
            }
            if let obj = dictionary["readingModes"] as? [String: AnyObject]{
                if let readingModes = NSEntityDescription.insertNewObject(forEntityName: "ReadingModes", into: context) as? ReadingModes {
                    if let _obj = obj["text"] as? Bool{
                        readingModes.text = _obj
                    }
                    if let _obj = obj["image"] as? Bool{
                        readingModes.image = _obj
                    }
                    volume.readingMode = readingModes
                }
            }
            if let obj = dictionary["imageLinks"] as? [String: AnyObject]{
                if let imageLinks = NSEntityDescription.insertNewObject(forEntityName: "ImageLinks", into: context) as? ImageLinks {
                    if let _obj = obj["smallThumbnail"] as? String{
                        imageLinks.smallThumbnail = _obj
                    }
                    if let _obj = obj["thumbnail"] as? String{
                        imageLinks.thumbnail = _obj
                    }
                    volume.imageLinks = imageLinks
                }
            }
            return volume
        }
        return nil
    }
    
    func setSaleInfoForBook(dictionary:[String: AnyObject],context:NSManagedObjectContext) -> SaleInfo?{
        if let saleInfo = NSEntityDescription.insertNewObject(forEntityName: "SaleInfo", into: context) as? SaleInfo {
            if let obj = dictionary["country"] as? String{
                saleInfo.country = obj
            }
            if let obj = dictionary["saleability"] as? String{
                saleInfo.saleability = obj
            }
            if let obj = dictionary["isEbook"] as? Bool{
                saleInfo.isEBook = obj
            }
            if let obj = dictionary["buyLink"] as? String{
                saleInfo.buyLink = obj
            }
            return saleInfo
        }
      return nil
    }
    
    func setAccessInfoForBook(dictionary:[String: AnyObject],context:NSManagedObjectContext) -> AccessInfo?{
        if let accessInfo = NSEntityDescription.insertNewObject(forEntityName: "AccessInfo", into: context) as? AccessInfo {
            if let obj = dictionary["country"] as? String{
                accessInfo.country = obj
            }
            if let obj = dictionary["viewability"] as? String{
                accessInfo.viewability = obj
            }
            if let obj = dictionary["embeddable"] as? Bool{
                accessInfo.embeddable = obj
            }
            if let obj = dictionary["publicDomain"] as? Bool{
                accessInfo.publicDomain = obj
            }
            if let obj = dictionary["textToSpeechPermission"] as? String{
                accessInfo.textToSpeechPermission = obj
            }
            if let obj = dictionary["epub"] as? [String:AnyObject]{
                if let ePub = NSEntityDescription.insertNewObject(forEntityName: "Epub", into: context)as? Epub{
                    if let _obj = obj["isAvailable"] as? Bool{
                        ePub.isAvailable = _obj
                    }
                    accessInfo.ePub = ePub
                }
            }
            if let obj = dictionary["pdf"] as? [String:AnyObject]{
                if let pdf = NSEntityDescription.insertNewObject(forEntityName: "Pdf", into: context)as? Pdf{
                    if let _obj = obj["isAvailable"] as? Bool{
                        pdf.isAvailable = _obj
                    }
                    if let _obj = obj["downloadLink"] as? String{
                        pdf.downloadLink = _obj
                    }
                    accessInfo.pdf = pdf
                }
            }
            if let obj = dictionary["webReaderLink"] as? String{
                accessInfo.webReaderLink = obj
            }
            if let obj = dictionary["accessViewStatus"] as? String{
                accessInfo.accessViewStatus = obj
            }
            if let obj = dictionary["quoteSharingAllowed"] as? Bool{
                accessInfo.quoteSharingAllowed = obj
            }
            return accessInfo
        }
        return nil
    }

    func getTopRatedBooks() -> [VolumeInfo]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VolumeInfo")
        let predicate = NSPredicate.init(format: "averageRating>=%d", 4)
        fetchRequest.predicate = predicate
        var array = [VolumeInfo]()
        do{
            array = try CoreDataManager.sharedInstance.getContext().fetch(fetchRequest) as! [VolumeInfo]

        }catch{}
        return array
    }
    
    func getVolumeInfoForId(id:String) -> VolumeInfo?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VolumeInfo")
        let predicate = NSPredicate.init(format: "items.id=%@", id)
        fetchRequest.predicate = predicate
        var info = [VolumeInfo]()
        do{
            info = try CoreDataManager.sharedInstance.getContext().fetch(fetchRequest) as! [VolumeInfo]
            
        }catch{}
        return info[0]
    }
    
    func searchBooksWithKeyWord(string:String) -> [VolumeInfo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VolumeInfo")
        let words = string.components(separatedBy: " ")
        var predicateArr = [NSPredicate]()
        for word in words {
            let predicate = NSPredicate(format: "title contains[c] %@ OR subtitle contains[c] %@ OR authors.authors contains[c] %@ OR categories.categories contains[c] %@", word, word,word,word)
            predicateArr.append(predicate)
        }
        let compound = NSCompoundPredicate(orPredicateWithSubpredicates: predicateArr)
        fetchRequest.predicate = compound
        var _array = [VolumeInfo]()
        do{
            _array = try CoreDataManager.sharedInstance.getContext().fetch(fetchRequest) as! [VolumeInfo]
            
        }catch{}
        return _array
    }
    func getFilteredBooks(categories:String,minDate:Int,maxDate:Int,minPage:Int,maxPage:Int) -> [VolumeInfo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VolumeInfo")
        var predicateArr = [NSPredicate]()
        if(categories.isEmpty){
            let predicate = NSPredicate(format: "publishedData>%@ AND publishedData<%@ AND pageCount>%@ AND pageCount<%@",String(minDate),String(maxDate),String(minPage),String(maxPage))
            predicateArr.append(predicate)

        }else{
            let words = categories.components(separatedBy: " ")
            for word in words {
                let predicate = NSPredicate(format: "categories.categories contains[c] %@ AND publishedData>%@ AND publishedData<%@ AND pageCount>%@ AND pageCount<%@", word,String(minDate),String(maxDate),String(minPage),String(maxPage))
                predicateArr.append(predicate)
                
            }

        }
        
        
        let compound = NSCompoundPredicate(orPredicateWithSubpredicates: predicateArr)
        fetchRequest.predicate = compound
        var _array = [VolumeInfo]()
        do{
            _array = try CoreDataManager.sharedInstance.getContext().fetch(fetchRequest) as! [VolumeInfo]
            
        }catch{}
        return _array
        
    }
    
    
    func getAllCategories() ->[Categories]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        var array = [Categories]()
        do{
            array = try CoreDataManager.sharedInstance.getContext().fetch(fetchRequest) as! [Categories]
            
        }catch{}
        return array
    }
    
    
    func saveJsonToCoreData(array: [[String: AnyObject]],callback:(Bool)->()) {
        _ = array.map{self.itemsEntityFrom(dictionary: $0)}
        do {
            try CoreDataManager.sharedInstance.persistentContainer.viewContext.save()
            callback(true)
        } catch let error {
            print(error)
            callback(false)
        }
    }
    
    
}
