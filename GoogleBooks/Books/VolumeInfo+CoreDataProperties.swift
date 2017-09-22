//
//  VolumeInfo+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension VolumeInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VolumeInfo> {
        return NSFetchRequest<VolumeInfo>(entityName: "VolumeInfo")
    }

    @NSManaged public var allowAnonLogging: Bool
    @NSManaged public var canonicalVolumeLink: String?
    @NSManaged public var contentVersion: String?
    @NSManaged public var infoLink: String?
    @NSManaged public var language: String?
    @NSManaged public var maturityRating: String?
    @NSManaged public var pageCount: Int64
    @NSManaged public var previewLink: String?
    @NSManaged public var printType: String?
    @NSManaged public var publishedData: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var averageRating: Int16
    @NSManaged public var averageCount: Int16
    @NSManaged public var authors: Author?
    @NSManaged public var categories: Categories?
    @NSManaged public var imageLinks: ImageLinks?
    @NSManaged public var industryIdentifiers: IndustryIdentifiers?
    @NSManaged public var items: Items?
    @NSManaged public var readingMode: ReadingModes?

}
