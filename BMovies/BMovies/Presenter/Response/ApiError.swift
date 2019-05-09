//
//  ApiError.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation

enum ApiError: Error, LocalizedError {
    
    case badRequest
    case parseFailed
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad request"
            
        case .parseFailed:
            return "JSON parse Failed"
        }
    }
}
