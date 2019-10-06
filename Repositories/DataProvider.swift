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
    private let api: MagicAPIProtocol

    public init(api: MagicAPIProtocol) {
        self.api = api
    }
}

extension DataProvider: SetsRepository {
    public func getAllSets() -> Observable<CardSets> {
        return api.send(path: .sets, method: .GET, parameters: [:])
    }
}

extension DataProvider: TypesRepository {
    func getAllTypes() -> Observable<CardTypes> {
        return api.send(path: .types, method: .GET, parameters: [:])
    }
}

extension DataProvider: CardsRepository {
    public func getCards(of type: String, in set: CardSet, at page: Int) -> Observable<Cards> {
        var params = [String: String]()
        params["type"] = type
        params["set"] = set.code
        params["page"] = String(page)
        return api.send(path: .cards, method: .GET, parameters: params)
    }
}
