//
//  NetworkingManager.swift
//  SafeKiddoRecruitmentTask
//
//  Created by Tymoteusz Pasieka on 20/09/2020.
//  Copyright © 2020 Tymoteusz Pasieka. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    func performNetworkTask<T: Decodable>(for url: String, type: T.Type, completion: @escaping (Result<T,NetworkError>) -> Void)
}

final class NetworkingManager: NetworkingProtocol {
    
    func performNetworkTask<T: Decodable>(for url: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.domainError))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.domainError))
            } else if let data = data {
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(.connectionError))
                    return
                }
                
                let response = Response(data: data)
                guard let decoded = response.decode(type) else {
                    completion(.failure(.decodingError))
                    return
                }
                
                
                completion(.success(decoded))
            }
        }.resume()
    }
}


enum NetworkError: Error {
    case domainError
    case decodingError
    case connectionError
    case firebaseError
}

//MARK: - response

struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Decodable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch _ {
            return nil
        }
    }
}



