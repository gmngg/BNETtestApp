//
//  RequestNet.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 24.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import UIKit

protocol RequestNetworkProtocol {
    func request(parameters: [String : String], completion: @escaping (Result<Data?, Error>) -> Void)
}

class RequestNetwork: RequestNetworkProtocol {
    private func url(parameters: [String : String]) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        urlComponents.path = API.path
        urlComponents.queryItems = parameters.map {
            URLQueryItem(
                name: $0, value: $1
            )
        }
        return urlComponents
    }
    
    private func createDataTask( from request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(
                        .failure(error)
                    )
                } else {
                    completion(
                        .success(data)
                    )
                }
            }
        }
    }
    
    func request(parameters: [String : String], completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = self.url(parameters: parameters).url else { return }
        var request = URLRequest(url: url)
        if let query = url.query {
            request.httpMethod = "POST"
            request.httpBody = query.data(using: .utf8)
            request.addValue(API.token, forHTTPHeaderField: "token")
        }
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    
}
