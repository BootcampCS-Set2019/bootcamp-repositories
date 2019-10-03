//
//  ImageRepositorySpec.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import Quick
import Nimble
import MTGSDKSwift

class ImageRepositorySpec: QuickSpec {
    override func spec() {

        var imageRepository: ImageRepository!

        describe("SetsRepository") {
            var image: UIImage?
            var error: NetworkError?
            let card: Card = Card()

            context("when API is return properly") {
                beforeEach {
                    imageRepository = ImageRepositoryMock(expectedResult: .success)
                    imageRepository.getImage(forCard: card, completion: { (responseImage, responseError) in
                        image = responseImage
                        error = responseError
                    })
                }

                it("should get CardSets") {
                    expect(image).toNot(beNil())
                }

                it("should get nil as Error") {
                    expect(error).to(beNil())
                }
            }

            context("when API is not return properly") {

                beforeEach {
                    imageRepository = ImageRepositoryMock(expectedResult: .failure)
                    imageRepository.getImage(forCard: card, completion: { (responseImage, responseError) in
                        image = responseImage
                        error = responseError
                    })
                }

                it("shouldn't get CardSets") {
                    expect(image).to(beNil())
                }

                it("should get NetworkError") {
                    expect(error).toNot(beNil())
                }
            }
        }
    }
}
