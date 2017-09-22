//
//  Categories+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var categories: String?
    @NSManaged public var volumeInfo: VolumeInfo?

}
