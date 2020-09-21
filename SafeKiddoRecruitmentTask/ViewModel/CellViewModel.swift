//
//  CellViewModel.swift
//  SafeKiddoRecruitmentTask
//
//  Created by Tymoteusz Pasieka on 20/09/2020.
//  Copyright © 2020 Tymoteusz Pasieka. All rights reserved.
//

import Foundation
import UIKit

class CellViewModel {
    private var avatar : Avatar
    private (set) var imageLoader: ImageLoaderProtocol
    
    init(avatar: Avatar, imageLoaderManager: ImageLoaderProtocol) {
        self.imageLoader = imageLoaderManager
        self.avatar = avatar
    }
    
    func getImageFromUrl(completion: @escaping (UIImage?) -> Void) {
        imageLoader.getImage(from: avatar.url) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                completion(UIImage(systemName: "circle"))
                break
                //fatalError(error.localizedDescription)
            case .success(let image):
                completion(image)
                break
            }
        }
    }
    
    var avatarId: String {
        return avatar.id
    }
    
}
