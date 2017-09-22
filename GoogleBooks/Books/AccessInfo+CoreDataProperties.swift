//
//  AccessInfo+CoreDataProperties.swift
//  GoogleBooks
//
//  Created by mac on 18/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import Foundation
import CoreData


extension AccessInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccessInfo> {
        return NSFetchRequest<AccessInfo>(entityName: "AccessInfo")
    }

    @NSManaged public var accessViewStatus: String?
    @NSManaged public var country: String?
    @NSManaged public var embeddable: Bool
    @NSManaged public var publicDomain: Bool
    @NSManaged public var quoteSharingAllowed: Bool
    @NSManaged public var textToSpeechPermission: String?
    @NSManaged public var viewability: String?
    @NSManaged public var webReaderLink: String?
    @NSManaged public var ePub: Epub?
    @NSManaged public var items: Items?
    @NSManaged public var pdf: Pdf?

}
