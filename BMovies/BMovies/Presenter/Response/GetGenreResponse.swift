//
//  GetGenreResponse.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation

class GetGenreResponse: NSObject, Codable {
    
    var genres: [Genre]?
    
    static func from(json: String) -> GetGenreResponse? {
        return JsonUtil<GetGenreResponse>.from(json: json)
    }
}

