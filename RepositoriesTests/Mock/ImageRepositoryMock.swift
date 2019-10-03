//
//  ImageRepositoryMock.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import MTGSDKSwift
import UIKit

class ImageRepositoryMock: ImageRepository {

    private var image: UIImage?
    private var error: NetworkError?

    init(expectedResult: MockExpectedResult) {
        switch expectedResult {
        case .success:
            self.image = UIColor.blue.image()
            self.error = nil
        case .failure:
            self.image = nil
            self.error = NetworkError.requestError(NSError(domain: "", code: 401, userInfo: nil))
        }
    }

    func getImage(forCard card: Card, completion: @escaping APIResponse<UIImage>) {
        completion(self.image, self.error)
    }
}
