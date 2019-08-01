//
//  JsonUtil.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation

public struct JsonUtil<T: Codable>  {
    
    public static func from(json: String) -> T? {
        if let jsonData = json.data(using: .utf8) {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            do {
                return try jsonDecoder.decode(T.self, from: jsonData)
                
            } catch {
                print(error)
            }
        }
        
        return nil
    }
}
