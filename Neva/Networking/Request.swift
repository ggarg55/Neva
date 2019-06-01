//
//  Request.swift
//  Neva
//
//  Created by Gourav  Garg on 31/05/19.
//  Copyright © 2019 Gourav  Garg. All rights reserved.
//

import Foundation

enum Network: String {
    case baseURL = "https://test-api.nevaventures.com/"
    //Add keys and other constants
}

//API Request for EndPoint
//TODO: Add Protocol Based Generic Request
class Request<T: Codable> {
    let path: String
    let method: HTTPMethod
    let headerParameters: [String: String]?
    let requestParameters: [String: Any?]?
    typealias completion = (T?) -> Void
    
    init(path: String = "", method: HTTPMethod = .get, headerParameters: [String: String]? = nil, requestParameters: [String: Any?]? = nil) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.requestParameters = requestParameters
    }
    
    //Create Request using Request structure Parameters
    func buildRequest() -> URLRequest {
        var components = URLComponents(string: Network.baseURL.rawValue)!
        components.path += path
        var request = URLRequest(url: components.url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch method {
        case .get, .delete:
            components.queryItems = headerParameters?.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        case .post, .put:
            if let params = requestParameters {
                request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            }
            else {
                request.httpBody = nil
            }
        }
        return request
    }

    func execute(completion: @escaping completion) {
        if !Reachability.isConnectedToNetwork() {
            print("Not Connected to Internet")
            completion(nil)
        }
        let request = self.buildRequest()
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error.debugDescription)
                completion(nil)
            }
            
            guard let res = response as? HTTPURLResponse else {
                print("API Response is Empty")
                completion(nil)
                return
            }
            
            if res.statusCode >= 200 && res.statusCode < 300, let data = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(response)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            } else {
                print("Api Failed")
                completion(nil)
            }
        }.resume()
    }
}
