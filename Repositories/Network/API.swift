//
//  MagicAPI.swift
//  Repositories
//
//  Created by matheus.filipe.bispo on 06/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Entities

public enum RequestType: String {
    case GET, POST, PUT, DELETE
}

public enum PathType: String {
    case cards, sets, types

    var entityName: String {
        switch self {
        case .cards:
            return "Card"
        default:
            return ""
        }
    }
}

public protocol APIProtocol {
    func send<T: Codable>(path: PathType,
                          method: RequestType,
                          parameters: [String: String]) -> Future<T, APIError>
}

public class API: APIProtocol {

    private let baseURL = "https://api.magicthegathering.io/v1/"

    private let session: URLSessionProtocol

    public init(session: URLSessionProtocol) {
        self.session = session
    }

    private func buildRequest(path: PathType,
                              method: RequestType,
                              parameters: [String: String]) -> URLRequest {
        let url = baseURL + path.rawValue
        guard var components = URLComponents(string: url) else {
            fatalError("Invalid URL")
        }

        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    public func send<T>(path: PathType,
                        method: RequestType,
                        parameters: [String: String]) -> Future<T, APIError>
        where T: Decodable, T: Encodable {

        return Future { future in
            let request = buildRequest(path: path, method: method, parameters: parameters)
            let task = self.session.dataTask(with: request) { data, _, _ in
                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    future.resolve(value: model)
                } catch {
                    future.reject(error: APIError.unavailable)
                }
            }

            task.resume()
        }
    }
}
