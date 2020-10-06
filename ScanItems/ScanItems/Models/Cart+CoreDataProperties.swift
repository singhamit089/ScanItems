//
//  Cart+CoreDataProperties.swift
//  
//
//  Created by Amit Singh on 07/10/20.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var price: Double
    @NSManaged public var quantity: Int32
    @NSManaged public var items: Item?

}
