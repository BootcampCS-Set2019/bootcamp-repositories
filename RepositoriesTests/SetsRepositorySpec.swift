//
//  SetsRepositoryTests.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import Quick
import Nimble
import MTGSDKSwift

class SetsRepositorySpec: QuickSpec {
    override func spec() {

        var setsRepository: SetsRepository!

        describe("SetsRepository") {
            var cardSets: [CardSet]?
            var error: NetworkError?

            context("when API is return properly") {

                beforeEach {
                    setsRepository = SetsRepositoryMock(expectedResult: .success)
                    setsRepository.getAllSets { (responseCardSets, responseError) in
                        cardSets = responseCardSets
                        error = responseError
                    }
                }

                it("should get CardSets") {
                    expect(cardSets).toNot(beNil())
                }

                it("should get nil as Error") {
                    expect(error).to(beNil())
                }
            }

            context("when API is not return properly") {

                beforeEach {
                    setsRepository = SetsRepositoryMock(expectedResult: .failure)
                    setsRepository.getAllSets { (responseCardSets, responseError) in
                        cardSets = responseCardSets
                        error = responseError
                    }
                }

                it("shouldn't get CardSets") {
                    expect(cardSets).to(beNil())
                }

                it("should get NetworkError") {
                    expect(error).toNot(beNil())
                }
            }

        }
    }
}
