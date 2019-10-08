//
//  APISpec.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 08/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories
import Quick
import Nimble
import Entities

class APISpec: QuickSpec {
    override func spec() {
        describe("API") {
            var api: APIProtocol!
            let session = MockURLSession()

            beforeEach {
                api = API(session: session)
            }

            context("When requesting") {

                it("should call resume") {
                    let dataTask = MockURLSessionDataTask()
                    session.nextDataTask = dataTask

                    let _: Future<Cards, APIError> = api!.send(path: PathType.cards,
                                                                 method: RequestType.GET,
                                                                 parameters: [:])

                    expect(dataTask.resumeWasCalled).to(beTrue())

                }

                it("should return data") {
                    let expectedData = """
                    {
                        "cards" : [
                            {
                            "id": "",
                            "name": "",
                            "imageUrl": ""
                            }
                        ]
                    }
                    """.data(using: .utf8)
                    session.nextData = expectedData

                    var actualCards: Cards?
                    let future: Future<Cards, APIError> = api!.send(path: PathType.cards,
                                                                    method: RequestType.GET,
                                                                    parameters: [:])
                    future.then({ (cards) in
                        actualCards = cards
                    })

                    expect(actualCards).toNot(beNil())
                }
            }
        }
    }
}
