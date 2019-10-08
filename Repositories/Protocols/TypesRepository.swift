//
//  TypesRepository.swift
//  Repositories
//
//  Created by matheus.filipe.bispo on 05/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//
import Entities

public protocol TypesRepository {
    func getAllTypes() -> Future<CardTypes, APIError>
}
