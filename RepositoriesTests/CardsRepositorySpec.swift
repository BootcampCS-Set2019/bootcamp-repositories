//
//  CardsRepositorySpec.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 03/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import Quick
import Nimble
import MTGSDKSwift
import Entities

class CardsRepositorySpec: QuickSpec {
    override func spec() {
        var cardsReposotory: CardsRepository!

        describe("CardsRepository") {
            var cards: [MagicCard]?
            var error: NetworkError?
            let setCode: String = "COD"
            var page: Int = 1

            context("when API is return properly") {

                context("requesting existing pages") {
                    beforeEach {
                        cardsReposotory = CardsRepositoryMock(expectedResult: .success, setCode: setCode)
                        cardsReposotory.getCards(inSet: setCode, atPage: page,
                                                 completion: { (responseCards, responseError) in
                                                    cards = responseCards
                                                    error = responseError
                        })
                    }

                    it("should get Cards") {
                        expect(cards).toNot(beNil())
                    }

                    it("should get nil as Error") {
                        expect(error).to(beNil())
                    }
                }

                context("requesting not existing pages") {
                    beforeEach {
                        page = 4
                        cardsReposotory.getCards(inSet: setCode,
                                                 atPage: page,
                                                 completion: { (responseCards, responseError) in
                                                    cards = responseCards
                                                    error = responseError
                        })

                        it("should get empty Cards array") {
                            expect(cards).to(beEmpty())
                        }

                        it("should get nil as Error") {
                            expect(error).to(beNil())
                        }
                    }
                }
            }

            context("when API is not return properly") {

                beforeEach {
                    cardsReposotory = CardsRepositoryMock(expectedResult: .failure, setCode: setCode)
                    cardsReposotory.getCards(inSet: setCode, atPage: 1,
                                             completion: { (responseCards, responseError) in
                                                cards = responseCards
                                                error = responseError
                    })
                }

                it("shouldn't get Cards") {
                    expect(cards).to(beNil())
                }

                it("should get NetworkError") {
                    expect(error).toNot(beNil())
                }
            }
        }
    }
}
