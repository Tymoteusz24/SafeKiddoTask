//
//  ViewModel.swift
//  SafeKiddoRecruitmentTask
//
//  Created by Tymoteusz Pasieka on 20/09/2020.
//  Copyright © 2020 Tymoteusz Pasieka. All rights reserved.
//

import Foundation


class DataListViewModel {
    private (set) var networkingManager: NetworkingProtocol!
    
    private var avatars: [Avatar]?
    
    init(avatars: [Avatar]) {
        self.avatars = avatars
    }
   
    init(networkingManager: NetworkingProtocol) {
        self.networkingManager = networkingManager
    }
    
}

//MARK: - Populating view model

extension DataListViewModel {
    func populateViewModel(url: String, completion: ((NetworkError?) -> Void)?){
        networkingManager.performNetworkTask(for: url, type: Array<Avatar>.self) { [weak self] (result) in
            switch result {
            case .failure(let error):
               completion?(error)
            case .success(let avatars):
                self?.avatars = avatars
                completion?(nil)
            }
        }
    }
}

//MARK: - Controller binding

extension DataListViewModel {
    var count: Int {
        return avatars?.count ?? 0
    }
    
    public func cellViewModel(index: Int) -> CellViewModel? {
        guard let avatars = avatars else {return nil}
        
        let vm = CellViewModel(avatar: avatars[index], imageLoaderManager: ImageLoaderManager())
        return vm
    }
}



   
