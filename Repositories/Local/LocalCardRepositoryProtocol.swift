//
//  LocalCardRepositoryProtocol.swift
//  Repositories
//
//  Created by elton.faleta.santana on 14/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Entities

public protocol LocalCardRepositoryProtocol {
    func insert(card: Card)
    func getAll() -> [Card]
    func delete(card: Card)
}
