//
//  DataModel.swift
//  SafeKiddoRecruitmentTask
//
//  Created by Tymoteusz Pasieka on 20/09/2020.
//  Copyright © 2020 Tymoteusz Pasieka. All rights reserved.
//

import Foundation

struct Avatar: Codable {
    let url: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case id = "avatar_id"
    }
}


