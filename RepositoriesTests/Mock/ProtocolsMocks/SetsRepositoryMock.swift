//
//  SetsRepositoryMock.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import MTGSDKSwift
import Entities

class SetsRepositoryMock: SetsRepository {
    private var sets: [MagicCardSet]?
    private var error: NetworkError?

    init(expectedResult: MockExpectedResult) {
        switch expectedResult {
        case .success:
            self.sets = Array(repeating: MagicCardSet(code: "", name: ""), count: 10)
            self.error = nil
        case .failure:
            self.sets = nil
            self.error = NetworkError.requestError(NSError(domain: "", code: 401, userInfo: nil))
        }
    }

    func getAllSets(completion: @escaping APIResponse<[MagicCardSet]>) {
        completion(self.sets, self.error)
    }
}
