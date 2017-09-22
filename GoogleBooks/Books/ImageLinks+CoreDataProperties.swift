//
//  ImageLinks+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension ImageLinks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageLinks> {
        return NSFetchRequest<ImageLinks>(entityName: "ImageLinks")
    }

    @NSManaged public var smallThumbnail: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var volumeInfo: VolumeInfo?

}
