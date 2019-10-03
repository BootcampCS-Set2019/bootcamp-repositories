//
//  CardsRepository.swift
//  Repositories
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import MTGSDKSwift

public protocol CardsRepository {
    func getCards(inSet setCode: String, atPage page: Int, completion: @escaping APIResponse<Card>)
}
