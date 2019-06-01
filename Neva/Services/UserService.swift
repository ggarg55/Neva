//
//  UserService.swift
//  Neva
//
//  Created by Gourav  Garg on 31/05/19.
//  Copyright © 2019 Gourav  Garg. All rights reserved.
//

import Foundation

final class UserService {
    
    typealias completion = (UsersDataList?) -> Void

    func getUserList(completion: @escaping completion) {
        Request().execute {(response) in
            completion(response)
        }
    }
    
    func filterList(_ userData: UsersDataList?) -> [UserData]? {
        guard let userData = userData else { return nil }
        var filteredUserData : [Int : UserData] = [:]
        //Filter Users based on ID
        userData.data?.forEach({
            if $0.id != nil {
                filteredUserData[$0.id!] = $0
            }
        })
        
        var users: [UserData] = []
        filteredUserData.forEach {
            users.append($0.value)
        }
        users = users.sorted(by: { (first, second) -> Bool in
            return first.id! < second.id!
        })
        return users
    }
}
