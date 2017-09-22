//
//  SaleInfo+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension SaleInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaleInfo> {
        return NSFetchRequest<SaleInfo>(entityName: "SaleInfo")
    }

    @NSManaged public var buyLink: String?
    @NSManaged public var country: String?
    @NSManaged public var isEBook: Bool
    @NSManaged public var saleability: String?
    @NSManaged public var items: Items?

}
