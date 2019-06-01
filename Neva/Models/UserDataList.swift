//
//  UserData.swift
//  Neva
//
//  Created by Gourav  Garg on 31/05/19.
//  Copyright © 2019 Gourav  Garg. All rights reserved.
//

import Foundation
struct UsersDataList : Codable {
    let code : Int?
    let message : String?
    let data : [UserData]?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([UserData].self, forKey: .data)
    }
    
}
