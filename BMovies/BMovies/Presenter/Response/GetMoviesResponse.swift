//
//  GetMoviesResponse.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation

class GetMoviesResponse: NSObject, Codable {
    
    var results: [Movie]?
    var page: Int = 0
    var totalResults: Int = 0
    var totalPages: Int = 0
    
    static func from(json: String) -> GetMoviesResponse? {
        return JsonUtil<GetMoviesResponse>.from(json: json)
    }
}
