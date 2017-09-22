//
//  Pdf+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension Pdf {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pdf> {
        return NSFetchRequest<Pdf>(entityName: "Pdf")
    }

    @NSManaged public var downloadLink: String?
    @NSManaged public var isAvailable: Bool
    @NSManaged public var accessInfo: AccessInfo?

}
