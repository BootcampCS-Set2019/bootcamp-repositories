//
//  URLSessionDataTaskProtocol.swift
//  Repositories
//
//  Created by elton.faleta.santana on 08/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Foundation

public protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
