//
//  APIMock.swift
//  RepositoriesTests
//
//  Created by elton.faleta.santana on 08/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

@testable import Repositories

class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?

    private (set) var lastURL: URL?

    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
        -> URLSessionDataTaskProtocol {
        lastURL = request.url

        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false

    func resume() {
        resumeWasCalled = true
    }
}
