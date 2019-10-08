//
//  MagicAPIMock.swift
//  RepositoriesTests
//
//  Created by matheus.filipe.bispo on 06/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories

class APISpy: APIProtocol {
    var invokedSend = false
    var invokedSendCount = 0
    // swiftlint:disable:next large_tuple
    var invokedSendParameters: (path: PathType, method: RequestType, parameters: [String: String])?
    var invokedSendParametersList = [(path: PathType, method: RequestType, parameters: [String: String])]()

    func send<T: Codable>(path: PathType, method: RequestType, parameters: [String: String]) -> Future<T, APIError> {
        return Future { _ in
            invokedSend = true
            invokedSendCount += 1
            invokedSendParameters = (path, method, parameters)
            invokedSendParametersList.append((path, method, parameters))
        }
    }
}
