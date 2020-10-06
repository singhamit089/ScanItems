//
//  DBStorageManager.swift
//  ScanItems
//
//  Created by Amit Singh on 06/10/20.
//  Copyright © 2020 singhamit089. All rights reserved.
//

import CoreData
import Foundation

class DBStorageManager {
    let persistentContainer: NSPersistentContainer!

    init(container: NSPersistentContainer) {
        persistentContainer = container
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    convenience init() {
        self.init(container: CoreDataManager.sharedInstance.persistentContainer)
    }

    lazy var mainContext: NSManagedObjectContext = {
        self.persistentContainer.viewContext
    }()

    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Item.self))

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)

        return frc
    }()

    func insertItems(with dictionary: [String: Any]) -> Item? {
        guard let item: Item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: mainContext) as? Item else { return nil }

        item.albumId = Int32(dictionary["albumId"] as! Int)
        item.id = Int32(dictionary["id"] as! Int)
        item.title = dictionary["title"] as? String
        item.url = dictionary["url"] as? String
        item.thumbnailUrl = dictionary["thumbnailUrl"] as? String

        if let price = dictionary["price"] {
            item.price = price as! Double
        } else {
            item.price = Double(0)
        }

        return item
    }

    func fetchAllItems() -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [Item]()
    }

    func remove(objectID: NSManagedObjectID) {
        let obj = mainContext.object(with: objectID)
        mainContext.delete(obj)
    }

    func save() {
        CoreDataManager.sharedInstance.saveContext()
    }

    func insertitemArrayInBatches(with array: Array<[String: Any]>) {
        let backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)

        backgroundContext.parent = mainContext

        backgroundContext.perform { // runs asynchronously
            autoreleasepool {
                array.chunked(by: 1000).map({ subArray in
                    subArray.map({ (dictionary) -> Item in

                        let item: Item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: backgroundContext) as! Item

                        item.albumId = Int32(dictionary["albumId"] as! Int)
                        item.id = Int32(dictionary["id"] as! Int)
                        item.title = dictionary["title"] as? String
                        item.url = dictionary["url"] as? String
                        item.thumbnailUrl = dictionary["thumbnailUrl"] as? String
                        item.price = dictionary["price"] as! Double
                        return item
                    })
                })
            }

            // only save once per batch insert
            do {
                try backgroundContext.save()
            } catch {
                print(error)
            }

            backgroundContext.reset()
        }
    }

    func deleteAllObjectsForEnity(entity: Any) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: mainContext)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getCart(with item: Item) -> Cart? {
        guard let cart: Cart = NSEntityDescription.insertNewObject(forEntityName: "Cart", into: mainContext) as? Cart else { return nil }

        cart.items = item
        cart.quantity = 1
        cart.price = item.price

        return cart
    }
    
    func insertCart(with cart:Cart) {
        
        var predicateArray = Array<NSPredicate>()
        
        if let itemID = cart.items?.id {
            let predicateItem = NSPredicate(format: "items.id == %d", itemID)
            predicateArray.append(predicateItem)
        }
        
         let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: predicateArray)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Cart.self))
        fetchRequest.predicate = predicateCompound
        //fetchRequest.sortDescriptors = [] //optionally you can specify the order in which entities should ordered after fetch finishes
    
        do {
            let results = try mainContext.fetch(fetchRequest)
            if results.count == 1 {
                save()
            }else {
                
                var cartArray = results as! [Cart]
                
                var totalQty = Int32(0)
                
                for cart in cartArray {
                    totalQty += cart.quantity
                }
                
                let firstCartObject =  cartArray.first
                firstCartObject?.quantity = totalQty
                firstCartObject?.price = (firstCartObject?.items?.price)! * Double(totalQty)
                
                cartArray.remove(at: 0)
                
                for cart in cartArray {
                   remove(objectID: cart.objectID)
                }
                
                save()
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

