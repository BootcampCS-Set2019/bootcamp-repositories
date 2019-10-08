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

class DataProviderSpec: QuickSpec {
    override func spec() {
        describe("DataProvider") {

            var dataProvider: DataProvider!
            var mock: APISpy!

            beforeEach {
                mock = APISpy()
                dataProvider = DataProvider(api: mock)
            }

            context("when trying to get Sets") {
                it("should get all Sets") {
                    _ = dataProvider.getAllSets()

                    expect(mock.invokedSendParameters?.path).to(equal(.sets))
                    expect(mock.invokedSendParameters?.method).to(equal(.GET))
                }
            }

            context("when trying to get Types") {
                it("should get all Types") {
                    _ = dataProvider.getAllTypes()

                    expect(mock.invokedSendParameters?.path).to(equal(.types))
                    expect(mock.invokedSendParameters?.method).to(equal(.GET))
                }
            }

            context("when trying to get Cards") {
                it("should get all Cards") {
                    let set = CardSet(code: "ABC", name: "", releaseDate: "")
                    _ = dataProvider.getCards(of: "type", in: set, at: 1)
                    let expectedParams = [
                        "type": "type",
                        "set": "ABC",
                        "page": "1"
                    ]

                    expect(mock.invokedSendParameters?.path).to(equal(.cards))
                    expect(mock.invokedSendParameters?.method).to(equal(.GET))
                    expect(mock.invokedSendParameters?.parameters).to(equal(expectedParams))
                }
            }
        }
    }
}
