//
//  Items+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var eTag: String?
    @NSManaged public var id: String?
    @NSManaged public var kind: String?
    @NSManaged public var sellfLink: String?
    @NSManaged public var isPending: Bool
    @NSManaged public var accessInfo: AccessInfo?
    @NSManaged public var saleInfo: SaleInfo?
    @NSManaged public var volumeInfo: VolumeInfo?

}
