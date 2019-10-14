//
//  Local.swift
//  Repositories
//
//  Created by elton.faleta.santana on 09/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import Entities

class StorableCard: Object {
    @objc dynamic var id: String
    @objc dynamic var name: String
//    @objc dynamic var set: String
//    @objc dynamic var imageUrl: String?
//    @objc dynamic var types: [String]
//    @objc dynamic var imageData: Data?

    init(id: String, name: String) {
        self.id = id
        self.name = name
        super.init()
    }

    required init() {
        fatalError("init() has not been implemented")
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}

public class LocalCardRepository: LocalCardRepositoryProtocol {
    private lazy var realm: Realm? = {
        do {
            let realm = try Realm()
            return realm
        } catch {
            return nil
        }
    }()

    public init() {}

    public func insert(card: Card) {
        guard let realm = self.realm else {
            return
        }
        let storable = StorableCard(id: card.id, name: card.name)

        do {
            try realm.write {
                realm.add(storable)
            }
        } catch {
            print("Error inserting: \(error)")
        }
    }

    public func getAll() -> [Card] {
        guard let realm = self.realm else {
            return []
        }
        let storables = realm.objects(StorableCard.self)
        let cards: [Card] = storables.map({ (storable) -> Card in
            return Card(id: storable.id, name: storable.name, imageUrl: "")
        })
        return cards
    }

    public func delete(card: Card) {
        guard let realm = self.realm else {
            return
        }

        let storable = StorableCard(id: card.id, name: card.name)

        realm.delete(storable)
    }
}
