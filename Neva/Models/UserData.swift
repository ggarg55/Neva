//
//  Data.swift
//  Neva
//
//  Created by Gourav  Garg on 31/05/19.
//  Copyright © 2019 Gourav  Garg. All rights reserved.
//

import Foundation
struct UserData : Codable {
    let id : Int?
    let name : String?
    let skills : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case skills = "skills"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        skills = try values.decodeIfPresent(String.self, forKey: .skills)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
