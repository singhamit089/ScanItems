//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Amit Singh on 06/10/20.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var albumId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var price: Double
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
