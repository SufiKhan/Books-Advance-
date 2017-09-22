//
//  Epub+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension Epub {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Epub> {
        return NSFetchRequest<Epub>(entityName: "Epub")
    }

    @NSManaged public var isAvailable: Bool
    @NSManaged public var accessInfo: AccessInfo?

}
