//
//  IndustryIdentifiers+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension IndustryIdentifiers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IndustryIdentifiers> {
        return NSFetchRequest<IndustryIdentifiers>(entityName: "IndustryIdentifiers")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var type: String?
    @NSManaged public var volumeInfo: VolumeInfo?

}
