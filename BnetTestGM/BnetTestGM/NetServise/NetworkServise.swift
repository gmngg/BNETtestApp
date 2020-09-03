//
//  TableViewCell.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 20.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import Foundation

protocol NetworkDataProtocol {
    func getSession(completion: @escaping(Result<SessionData?, Error>) -> Void)
    func getNotes(session: String, completion: @escaping(Result<NoteData?, Error>) -> Void)
    func addEntry(session: String, body: String, completion: @escaping(Result<SessionData?, Error>) -> Void)
}

final class NetworkData: NetworkDataProtocol {
    
    static let networkData = NetworkData()
    let requestNetwork = RequestNetwork()
    
    func addEntry(session: String, body: String, completion: @escaping (Result<SessionData?, Error>) -> Void) {
        let parameters = ["session": session,
                          "body" : body,
                          "a" : API.addEntry
                        ]
        self.fetchJSON(parameters: parameters, response: completion)
    }
    
    func getNotes(session: String, completion: @escaping (Result<NoteData?, Error>) -> Void) {
        let parameters = ["session" : session,
                          "a" : API.getEntries]
        self.fetchJSON(parameters: parameters, response: completion)
    }
    
    func getSession(completion: @escaping (Result<SessionData?, Error>) -> Void) {
        let parameters = ["a" : API.newSession]
        self.fetchJSON(parameters: parameters, response: completion)
    }
    
    private func fetchJSON<T : Decodable>(parameters: [String : String], response: @escaping(Result<T?, Error>) -> Void) {
        requestNetwork.request(parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                let decodedData = self.decodeJSON(type: T.self, from: data)
                response(.success(decodedData))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
}
