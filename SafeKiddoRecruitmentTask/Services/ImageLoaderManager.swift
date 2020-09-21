//
//  ImageLoaderManager.swift
//  SafeKiddoRecruitmentTask
//
//  Created by Tymoteusz Pasieka on 20/09/2020.
//  Copyright © 2020 Tymoteusz Pasieka. All rights reserved.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
     func getImage(from url: String, completion: @escaping (Result< UIImage, NetworkError>) -> Void)
}

class ImageLoaderManager: ImageLoaderProtocol {
    
    func getImage(from url: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.domainError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                
                completion(.failure(.connectionError))
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    completion(.success(image))
                } else {
                    completion(.failure(.decodingError))
                }
            }
            
        }.resume()
    }
    
}
