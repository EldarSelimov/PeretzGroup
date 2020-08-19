//
//  NetworkManager.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let host = "https://peretz-group.ru/api/v2/products?category=93&key=47be9031474183ea92958d5e255d888e47bdad44afd5d7b7201d0eb572be5278"
    
    func getMenu(onSuccess: @escaping ([MenuModel]) -> Void,
                 onError: @escaping (String) -> Void) {
        AF
            .request(host, method: .get, parameters: nil)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    onError(error.localizedDescription)
                    
                case .success(let value):
                    if let arrayDictionary = value as? [[String: Any]] {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: arrayDictionary, options: .fragmentsAllowed)
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode([MenuModel].self, from: data)
                            onSuccess(result)
                        } catch {
                            onError("Parse error: \(error.localizedDescription)")
                        }
                    }
                }
        }
    }
}
