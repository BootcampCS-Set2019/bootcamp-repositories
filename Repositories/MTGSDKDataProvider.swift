//
//  MTGSDKDataProvider.swift
//  Repositories
//
//  Created by elton.faleta.santana on 04/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import MTGSDKSwift
import Entities

public class MTGSDKDataProvider {
    var magic = Magic()
}

extension MTGSDKDataProvider: SetsRepository {
    public func getAllSets(completion: @escaping APIResponse<[MagicCardSet]>) {
        magic.fetchSets([]) { (result) in
            switch result {
            case .success(let sets):
                let magicCardSets: [MagicCardSet] = sets.map({ (set) -> MagicCardSet in
                    return MagicCardSet(code: set.code, name: set.name)
                })
                completion(magicCardSets, nil)
            case .error(let error):
                completion(nil, error)
            }
        }
    }
}

extension MTGSDKDataProvider: CardsRepository {
    public func getCards(inSet setCode: String, atPage page: Int, completion: @escaping APIResponse<[MagicCard]>) {
        let setCardParameter = CardSearchParameter(parameterType: .set, value: setCode)
        let configuration = MTGSearchConfiguration(pageSize: 100, pageTotal: 1)
        self.magic.fetchCards([setCardParameter], configuration: configuration) { (result) in
            switch result {
            case .success(let cards):
                let magicCards: [MagicCard] = cards.map({ (card) -> MagicCard in
                    return MagicCard(name: card.name, imageUrl: card.imageUrl, id: card.id)
                })
                completion(magicCards, nil)
            case .error(let error):
                completion(nil, error)
            }
        }
    }
}

extension MTGSDKDataProvider: ImageRepository {
    public func getImage(forCard magicCard: MagicCard, completion: @escaping APIResponse<UIImage>) {
        var card = Card()
        card.imageUrl = magicCard.imageUrl
        self.magic.fetchImageForCard(card) { (result) in
            switch result {
            case .success(let image):
                completion(image, nil)
            case .error(let error):
                completion(nil, error)
            }
        }
    }
}
