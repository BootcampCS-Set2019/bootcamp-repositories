//
//  SetsRepository.swift
//  Repositories
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Entities

public protocol SetsRepository {
    func getAllSets() -> Future<CardSets, APIError>
}
