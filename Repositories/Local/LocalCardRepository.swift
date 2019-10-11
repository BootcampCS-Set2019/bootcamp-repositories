//
//  Local.swift
//  Repositories
//
//  Created by elton.faleta.santana on 09/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Foundation
import CoreData

public class LocalCardRepository {
    private var entityName = "Card"
    var manager: DBManager
    var context: NSManagedObjectContext

    public init() {
        self.manager = DBManager()
        self.context = manager.persistentContainer.viewContext
    }

    public func getAll() -> Future<[Card], APIError> {
        return Future { future in
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)

            do {
                let results = try self.context.fetch(request)
                let cards: [Card] = (results as [NSManagedObject]).map({ (result) -> Card in
                        let card = Card()
                        card.id = result.value(forKey: "id") as? String
                        card.name = result.value(forKey: "name") as? String
//                        card.imageUrl = result.value(forKey: "imageUrl") as? String
                        card.set = result.value(forKey: "set") as? String
//                        card.types = result.value(forKey: "types") as? [String]
//                        card.imageData = result.value(forKey: "imageData") as? Data
                        return card
                    })

                future.resolve(value: cards)
            } catch {
                future.reject(error: APIError.unavailable)
            }
        }
    }

    public func insert(card: Card) -> Future<Bool, APIError> {
        return Future { future in

            guard let cardEntityDescription = NSEntityDescription.entity(forEntityName: self.entityName, in: self.context) else {
                future.reject(error: APIError.unavailable)
                return
            }

            let cardManagedObject = NSManagedObject(entity: cardEntityDescription, insertInto: self.context)
            cardManagedObject.setValue(card.id,forKeyPath: "id")
            cardManagedObject.setValue(card.image,forKeyPath: "image")
            cardManagedObject.setValue(card.name,forKeyPath: "name")
//            cardManagedObject.setValue(card.imageUrl,forKeyPath: "imageUrl")
            cardManagedObject.setValue(card.set,forKeyPath: "set")
//            cardManagedObject.setValue(card.types,forKeyPath: "types")
//            cardManagedObject.setValue(card.imageData,forKeyPath: "imageData")



            do {
                try self.manager.saveContext()
                future.resolve(value: true)
            } catch {
                future.reject(error: APIError.unavailable)
            }
        }
    }

    public func delete(card: Card) -> Future<Bool, APIError> {
        return Future { future in

            guard let cardEntityDescription = NSEntityDescription.entity(forEntityName: self.entityName, in: self.context) else {
                future.reject(error: APIError.unavailable)
                return
            }

            let cardManagedObject = NSManagedObject(entity: cardEntityDescription, insertInto: self.context)
            cardManagedObject.setValue(card.id,forKeyPath: "id")
            cardManagedObject.setValue(card.image,forKeyPath: "image")
            cardManagedObject.setValue(card.name,forKeyPath: "name")
//            cardManagedObject.setValue(card.imageUrl,forKeyPath: "imageUrl")
            cardManagedObject.setValue(card.set,forKeyPath: "set")
//            cardManagedObject.setValue(card.types,forKeyPath: "types")
//            cardManagedObject.setValue(card.imageData,forKeyPath: "imageData")

            self.context.delete(cardManagedObject)

            do {
                try self.manager.saveContext()
                future.resolve(value: true)
            } catch {
                future.reject(error: APIError.unavailable)
            }
        }
    }
}
