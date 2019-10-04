//
//  MTGSDKDataProviderSpec.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 04/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import Quick
import Nimble
import Entities

class MTGSDKDataProviderSpec: QuickSpec {
    override func spec() {
        var dataProvider: MTGSDKDataProvider!

        describe("MTGSDKDataProvider") {
            dataProvider = MTGSDKDataProvider()

            context("when trying to get Sets") {

                it("should get all Sets") {
                    waitUntil(action: { (done) in
                        dataProvider.getAllSets(completion: { (sets, _) in
                            expect(sets).toNot(beNil())
                        })
                        done()
                    })
                }
            }

            context("when trying to get Cards") {
                var set: MagicCardSet = MagicCardSet(code: "", name: "")

                describe("with valid code") {
                    beforeEach {
                        set.code = "10E"
                    }
                    it("should get cards") {
                        waitUntil(action: { (done) in
                            dataProvider.getCards(inSet: set.code!, atPage: 1, completion: { (cards, _) in
                                expect(cards).toNot(beNil())
                            })
                            done()
                        })
                    }
                }

                describe("with valid code") {
                    beforeEach {
                        set.code = "invalid"
                    }
                    it("should get cards") {
                        waitUntil(action: { (done) in
                            dataProvider.getCards(inSet: set.code!, atPage: 1, completion: { (cards, _) in
                                expect(cards).to(beEmpty())
                            })
                            done()
                        })
                    }
                }
            }

            context("when trying to get Image for Card") {
                var card: MagicCard = MagicCard(name: "", imageUrl: "", id: "")

                describe("with valid URL") {
                    beforeEach {
                        card.imageUrl = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card"
                    }
                    it("should get card Image") {
                        waitUntil(timeout: 10, action: { (done) in
                            dataProvider.getImage(forCard: card, completion: { (image, _) in
                                expect(image).toNot(beNil())
                            })
                            done()
                        })
                    }
                }

                describe("with invalid URL") {
                    beforeEach {
                        card.imageUrl = "invalid"
                    }
                    it("should get card Image") {
                        waitUntil(action: { (done) in
                            dataProvider.getImage(forCard: card, completion: { (image, _) in
                                expect(image).to(beNil())
                            })
                            done()
                        })
                    }
                }
            }
        }
    }
}
