//
//  DataProvider.swift
//  Repositories
//
//  Created by elton.faleta.santana on 04/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//
import Entities
import RxSwift

public class DataProvider {
    private let api: APIProtocol

    public init(api: APIProtocol = API(session: URLSession.shared)) {
        self.api = api
    }
}

extension DataProvider: SetsRepository {
    public func getAllSets() -> Future<CardSets, APIError> {
        return api.send(path: .sets, method: .GET, parameters: [:])
    }
}

extension DataProvider: TypesRepository {
    public func getAllTypes() -> Future<CardTypes, APIError> {
        return api.send(path: .types, method: .GET, parameters: [:])
    }
}

extension DataProvider: CardsRepository {
    public func getCards(of type: String, in set: CardSet, at page: Int) -> Future<Cards, APIError> {
        var params = [String: String]()
        params["type"] = type
        params["set"] = set.code
        params["page"] = String(page)

        return api.send(path: .cards, method: .GET, parameters: params)
    }
}
