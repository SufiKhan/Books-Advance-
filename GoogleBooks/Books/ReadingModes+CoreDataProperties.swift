//
//  ReadingModes+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension ReadingModes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReadingModes> {
        return NSFetchRequest<ReadingModes>(entityName: "ReadingModes")
    }

    @NSManaged public var image: Bool
    @NSManaged public var text: Bool
    @NSManaged public var volumeInfo: VolumeInfo?

}
