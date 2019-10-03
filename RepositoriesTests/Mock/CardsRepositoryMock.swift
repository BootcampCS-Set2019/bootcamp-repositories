//
//  CardsRepositoryMock.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import MTGSDKSwift

class CardsRepositoryMock: CardsRepository {
    private var setCode: String
    private var cards: [Card]?
    private var error: NetworkError?
    private var expectedResult: MockExpectedResult

    init(expectedResult: MockExpectedResult, setCode: String) {
        self.setCode = setCode
        self.expectedResult = expectedResult
        switch self.expectedResult {
        case .success:
            self.cards = Array(repeating: Card(), count: 130)
            self.error = nil
        case .failure:
            self.cards = nil
            self.error = NetworkError.requestError(NSError(domain: "", code: 401, userInfo: nil))
        }
    }

    func getCards(inSet setCode: String, atPage page: Int, completion: @escaping APIResponse<[Card]>) {
        switch self.expectedResult {
        case .failure:
            completion(nil, self.error)
        case .success:
            guard let cards = self.cards else {
                return
            }
            if setCode == setCode && page < cards.count/100 {
                let startIndex = 0 + (100 * (page-1))
                let finalIndex = 100 * page
                let response = Array(cards[startIndex..<finalIndex])
                completion(response, self.error)
            } else if setCode == setCode && page < cards.count {
                completion([], self.error)
            } else {
                completion([], self.error)
            }
        }
    }
}
