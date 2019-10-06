//
//  MagicAPI.swift
//  Repositories
//
//  Created by matheus.filipe.bispo on 06/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import Entities
import RxSwift

public enum RequestType: String {
    case GET, POST, PUT, DELETE
}

public enum PathType: String {
    case cards, sets, types
}

public protocol MagicAPIProtocol {
    func send<T: Codable>(path: PathType, method: RequestType, parameters: [String: String]) -> Observable<T>
}

public class MagicAPI: MagicAPIProtocol {
    private let baseURL = "https://api.magicthegathering.io/v1/"

    public init() {}

    private func buildRequest(path: PathType,
                              method: RequestType,
                              parameters: [String: String]) -> URLRequest {
        let url = baseURL + path.rawValue
        guard var components = URLComponents(string: url) else {
            fatalError("Invalid URL")
        }

        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    public func send<T: Codable>(path: PathType,
                                 method: RequestType,
                                 parameters: [String: String] = ["": ""]) -> Observable<T> {

        return Observable<T>.create { [unowned self] observer in
            let request = self.buildRequest(path: path, method: method, parameters: parameters)

            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
