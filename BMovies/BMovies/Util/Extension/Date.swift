//
//  Date.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation

extension Date {
    
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy".localized
        
        return dateFormatter.string(from: self)
    }
}
